From: kd@flaga.is
Subject: Re: glibc........ memory limitations.... ideas?
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF44D0F5CF.9C737F35-ON00256811.003F104D@flaga.is>
Date: Thu, 21 Oct 1999 11:29:20 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hi,

I am no expert but DRAM takes a lot of current when you access it. And I
suspect that if you double the memory size the refresh cycle current is
approx doubled.
So if you have the fs also in DRAM you essentially make memory accesses
more frequently and therfore you draw more current.

I made a quick measurement on the 4MB simm, no parity, 5V  I have in my
board and it looks like the DRAM is drawing something like 10mA just in
refresh cycle (no memory accesses).
When the kernel has booted it is drawing close to 110mA. And as I
understand from the HW-engeneers 100mA is alot!! 8-)

I suspect that it is possible to "strip down" glibc. But I have no Idea how
much work that is.

Has anyone any experience with NewLib? Do you think it is easy to mix
pthread or LinuxThreads and NewLib and stdlibc++?
K.D.



                                                                                                                                                    
                    Dan Malek <dan@netx4.com>                                                                                                       
                    Sent by:                                To:     kd@flaga.is                                                                     
                    owner-linuxppc-embedded@lists.li        cc:     linuxppc-embedded@lists.linuxppc.org                                            
                    nuxppc.org                              Subject:     Re: glibc........ memory limitations.... ideas?                            
                                                                                                                                                    
                                                                                                                                                    
                    10/20/99 07:18 PM                                                                                                               
                                                                                                                                                    
                                                                                                                                                    





kd@flaga.is wrote:


> Compressed filesystems is one option but that means we have to increase
the
> size of the DRAM and that again means increased current drain. Limited
> battery resources is
> one of our contraints also.

Just because I need to learn something today, does memory really take
that much power?


> How do you guys cram all the software you want into so small space?

I am still using the old R4 libc-1.99 and associated libararies
for this reason.

One of the differences is that glibc2 just simply has more stuff
in it, which was contained in separate libraries of the past.  If
you want lots of the workstation features in your embedded system,
you will still end up with lots of library space used.

> ... Are
> there any othre c and c++ libraries that are smaller but provides access
to
> threads (pthreads) and
> work with linux?


Here again, I am a minimalist.  I don't use pthreads, as the
implementation is very heavyweight.  I just use Linux threads and
some simple atomic operations for synchronization.  I certainly
don't use C++ in a resource constrained embedded environment.
All of my embedded applications have used compressed ram disks
in Flash rom....It doesn't take long before you have an application
that needs a temporary file of some kind.


     -- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
