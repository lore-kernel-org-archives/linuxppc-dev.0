From: cajus.hahn@de.abb.com
Subject: Re:Semctl system call gives Segmentation Fault
To: linuxppc-embedded@lists.linuxppc.org
Cc: shivkumarb@hotmail.com
Message-ID: <OFBB0BA373.AC8B8DCD-ONC1256DF1.002361B0-C1256DF1.00270785@de.abb.com>
Date: Wed, 3 Dec 2003 08:06:18 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have the same problem.
It looks like a problem with the glibc.
My gdb reports:
"Program receives signal SIGSEGV, Segmentation fault.
0x0ff890f4 in semctl() from lib/libc.so.6"

I tried to find out what is happening:
semctl() takes three or  four parameters:
semctl( int semid, int semnum, int cmd, arg)
where "arg"  should be optional depending on the command "cmd".

Problems:
a) you always need four parameters, if you do not provide parameter #4 you
get SIGSEGV !
int dummy;
value=semctl(semaphore_id, 0, GETVAL);   /* you get SIGSEGV ! */
value=semctl(semaphore_id, 0, GETVAL,&dummy);   /* works */
semctl(semaphore_id, 0, IPC_RMID);  /* you get SIGSEGV ! */
semctl(semaphore_id, 0, IPC_RMID, &dummy);  /* works  */

b) "arg" needs to be a pointer, even for commands that do not really use
parameter #4 !
semctl(semaphore_id, 0, SETVAL, init_val);   /* you get SIGSEGV ! */
semctl(semaphore_id, 0, SETVAL, &init_val);   /* works !!! */

Using a pointer for the value in SETVAL is only a workaround !
Keep this in mind, if you are changing to a new (correct working) glibc!

Cajus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
