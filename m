Message-ID: <3FBA59A7.5040904@kienhoefer.com>
Date: Tue, 18 Nov 2003 09:40:55 -0800
From: Juergen Kienhoefer <juergen@kienhoefer.com>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: cache coherence problem: FIXED
References: <3FB972E8.5090701@kienhoefer.com>	 <1069122238.7168.63.camel@gaston>  <3FB9A77C.3030101@kienhoefer.com>	 <1069132955.7170.120.camel@gaston> <1069133049.7168.123.camel@gaston>
Content-Type: multipart/mixed;
 boundary="------------010200030308060606050800"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------010200030308060606050800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ben, et al.
Thanks, the test program is fixed and working.
I appreciate your help very much!!!
See attachment
Juergen


Benjamin Herrenschmidt wrote:

>On Tue, 2003-11-18 at 16:22, Benjamin Herrenschmidt wrote:
>
>
>>On Tue, 2003-11-18 at 16:00, Juergen Kienhoefer wrote:
>>
>>
>>>Guys,
>>>Thank you very much for the ideas.
>>>Basically, what I need to do is:
>>>dcbst
>>>sync
>>>iccci
>>>
>>>
>>^^^^^^^
>>No: icbi
>>
>>
>>
>>>sync
>>>isync
>>>for every 32 bytes of the memory block I put code in.
>>>
>>>
>
>Actually, to be precise, you need:
>
> 1) A loop of dcbst's over every cache line crossed by your code
> 2) one sync
> 3) A loop of icbi's over every cache line crossed by your code
> 4) one sync, one isync
>
>Ben.
>
>
>



--------------010200030308060606050800
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

static inline void clear_icache(void *p)
{
    asm volatile ("dcbst 0,%0;
                   sync;
                   icbi 0,%0;
                   sync;
                   isync" : : "r" (p));
}


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
    //loc = (long*)0x62802000; // set the address
    // always illegal instruction
    loc = (long*)0x62801b44;
    //loc = (long*)0x62801000;
    loc[0] = returninstr0;
    loc[1] = returninstr1;

    printf( "new code: addr %x, %x\n", loc, loc[0] );

    clear_icache( loc );

    init = (int (*)(void))loc;
    returned = init();

    printf( "function returned %d\n", returned );

}

--------------010200030308060606050800--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
