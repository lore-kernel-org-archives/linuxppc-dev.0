Subject: Core dump: Arch/ppc/boot/mkprep.c and Cross Compilers on IRIX/Solaris
Date: Wed, 4 Aug 1999 00:02:07 -0000
From: Grant Erickson <erick205@tc.umn.edu>
To: <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Message-Id: <iss.2bb5.37a7e55d.a8170.1@mhub2.tc.umn.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I recently completed Linux/PPC cross compilers running on both IRIX 6.5 
and on Solaris 2.7 and ran into a core dump in arch/ppc/boot while 
building 'make zImage' on both w/ the 2.2.10 source tree. I tracked down 
the build process and the core dump occured during the following command: 
'mkprep -pbp zvmlinux zImage'. Examples:

     grant@teddy% uname -a
     SunOS teddy 5.7 Generic sun4u sparc SUNW,Ultra-5_10
     
     grant@teddy% mkprep -pbp zvmlinux zImage
     Bus error (core dumped)

Visually, the code "looks" OK; however, on IRIX, I ran it through Purify 
and came up with the following analysis:

     grant@danube% uname -a
     IRIX danube 6.5 11051214 IP32
     
     grant@danube% 
     ****  Purify instrumented ./mkprep.pure (pid 64174 at Wed Aug  4 
01:17:31 1999)
      * Command-line: ./mkprep.pure -pbp zvmlinux zImage
      * Options settings: -cache-dir=/tmp -purify \
        -purify-home=/usr/local/pure/purify-4.0.1-irix6

     ****  Purify instrumented ./mkprep.pure (pid 64174)  ****
     COR: Fatal core dump:
       * This is occurring while in:
             write_prep_partition [mkprep.c:208]
                    #else
                      /* This has to be 0 on the PowerStack? */
                    #ifdef __i386__
                      pe->beginning_sector  = 0;
                    #else
                --->  pe->beginning_sector  = cpu_to_le32(0);
                    #endif /* __i386__ */
                    #endif
                    
                    #ifdef __i386__
                      pe->number_of_sectors = 2*18*80-1;

             main           [mkprep.c:134]
                      /*if ( !prep )*/
                      lseek(in_fd, elfhdr_size, SEEK_SET);
                    
                      /* write prep partition if necessary */
                      if ( prep )
                --->          write_prep_partition( in_fd, out_fd );

                      /* write input image to bootimage */
                      if ( asmoutput )
                              write_asm_data( in_fd, out_fd );
                      else

             __istart       [crt1tinit.s]
      * Received signal 10 (SIGBUS - Bus error)
      * Handler function: SIG_DFL
      * Faulting address = 0x4030b8
      * Signal mask: (SIGBUS)
      * Pending signals:
        Bus error (core dumped)

I suspect there are some endian (although, this does* run fine on 
Linux/PPC and Linux/x86) or structure packing issues.

Anyone else run into this yet in a cross-development environment? If so 
and you've found a fix please e-mail me or the list any patches you may 
have created. Otherwise, I'm off to find a fix!

It seems like what's being done here is that a PREP disk "block" is being 
generated (not sure what that is exactly though). It might make more 
sense to just write out the whole block in memory first and then byte 
swap it as appropriate for the machine on which the command is being run.

     

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
