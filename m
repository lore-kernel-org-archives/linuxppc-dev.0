Message-ID: <3FB972E8.5090701@kienhoefer.com>
Date: Mon, 17 Nov 2003 17:16:24 -0800
From: Juergen Kienhoefer <juergen@kienhoefer.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: cache coherence problem
Content-Type: multipart/mixed;
 boundary="------------020201090004070600050603"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------020201090004070600050603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Guys,
Look at the folloging test program. It mmaps memory, puts some
instructions in it and executes it.
Sometimes it works, sometimes it crashes with illegal instruction.
This smells like cache problems.
Should the kernel clean the instruction cache for these addresses
in mmap system call?
Thanks for any thoughts!
Juergen



--------------020201090004070600050603
Content-Type: text/plain;
 name="mmapexec.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmapexec.c"


#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <errno.h>
#include <sys/ptrace.h>
#include <signal.h>
#include <sched.h>


int main( int argc, char** argv ) {
    long* loc;
    int (*init)(void);
    long returninstr0 = 0x38600009; // li r3,4
    long returninstr1 = 0x4e800020; // blr
    int returned;
    int fd;
    char zero;
    char tempfile[20] = { "test-XXXXXX" };

    printf( "start of test\n" );


    fd = mkstemp( tempfile );
    printf( "memfile name test-XXXXXX, fd %d\n", fd );
    if (fchmod(fd, 0777) < 0){
	perror("fchmod");
	exit(1);
    }
    if( lseek( fd, 32768*1024, SEEK_SET ) != 32768*1024 ){ //32M
	perror("lseek");
	exit(1);
    }
    zero = 0;
    if( write(fd, &zero, 1 ) != 1){
	perror("write");
	exit(1);
    }
    if( fcntl(fd, F_SETFD, FD_CLOEXEC ) != 0)
	perror("Setting FD_CLOEXEC failed");


    loc = mmap( (void *) 0x62800000, 12288,
	        PROT_READ | PROT_WRITE | PROT_EXEC,
	        MAP_SHARED | MAP_FIXED,
	        fd, 0x3a0000);

    printf( "memory allocated at addr %x\n", loc );
    printf( "data %x\n", loc[0] );

    // random behaviour, sometimes works, sometimes illegal instruction
    //loc = (long*)0x62800000; // set the address
    loc = (long*)0x62802000; // set the address
    // always illegal instruction
    //loc = (long*)0x62801b44;
    //loc = (long*)0x62801000;
    loc[0] = returninstr0;
    loc[1] = returninstr1;

    printf( "new code: addr %x, %x\n", loc, loc[0] );

    init = (int (*)(void))loc;
    returned = init();

    printf( "function returned %d\n", returned );

}

--------------020201090004070600050603--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
