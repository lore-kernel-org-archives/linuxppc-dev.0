Return-Path: <raul.moreno@telvent.abengoa.com>
Received: from envio.abengoa.com (envio.abengoa.com [217.15.37.68])
	by ozlabs.org (Postfix) with ESMTP id E1AFFDE186
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Feb 2008 04:54:39 +1100 (EST)
In-Reply-To: <47BD9936.2000400@dlasys.lcl>
Subject: Re: initramfs problem - /init file
To: dhlii@dlasys.net
Message-ID: <OFFA27553C.639D7A97-ONC12573F6.0055F84D-C12573F6.00587AD1@abengoa.com>
Date: Thu, 21 Feb 2008 17:05:59 +0100
From: raul.moreno@telvent.abengoa.com
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Dave,

I have just figured out the problem... an stupid error... By mistake I =
took
the filesystem compiled to intel instead to ppc. I guess I forgot to as=
sign
the right cross-compile toolchain. So the microprocessor can't execute =
the
init file.

Now it works.
Anyway thank you for your time.


Ra=FAl Moreno



"David H. Lynch Jr." <dhlii@dlasys.lcl>
"David H. Lynch Jr."
21/02/2008 16:31
Por favor, responda a dhlii
                                                                       =
                                                
 Para:   raul.moreno@telvent.abengoa.com                               =
                                                
                                                                       =
                                                
 cc:     linuxppc-embedded <linuxppc-embedded@ozlabs.org>              =
                                                
                                                                       =
                                                
 Asunto: Re: initramfs problem - /init file                            =
                                                
                                                                       =
                                                





raul.moreno@telvent.abengoa.com wrote:
> Hello Dave,
>
> thanks for your answer. I agree with you, the easy way is to assign t=
he
> rootfs directory. I gave the filesystem as a cpio file because it is =
the
> same (the kernel takes the rootfs and converts it to a cpio format), =
but
> the compilation is faster. Anyway, although now I do as you said, I s=
till
> get the error:
> "Failed to execute /init
> Kernel panic - not syncing: No init found.  Try passing init=3D optio=
n to
> kernel."
> I can't understand why it happens. I check the permission of /init an=
d
> /sbin/init and everything seems to me OK.
>
> Any idea?
>
    I have had the same problem.
    Things I can remember:
          Permissions,
          console setup,
          watch out for symbolic links to init.
          Also is your init and executable or  script ?
          I think you get this failure if ANYTHING goes wrong exec'ing
init.
             Like - it found init but could not execute a shell.
             or the shell required a library it could not find.
          Or something is not quite right with your Virtual memory -
            Linux exec's by forcing chained page faults.

       One thing I tried was a simple "hello world" in ppc assembler -
no libraries,
       and named it /init. When it succeeded I was able to narrow my
problem down..
       Then tried a "hello world" in C with a static library, then
dynamic, then ...
       Basically building more and more complex /init's until I isolate=
d
what was failing.






> Ra=FAl Moreno
>
>
>
>


--
Dave Lynch
     DLA Systems
Software Development:
Embedded Linux
717.627.3770                    dhlii@dlasys.net
http://www.dlasys.net
fax: 1.253.369.9244                                               Cell:=

1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too=

numerous to list.

"Any intelligent fool can make things bigger and more complex... It tak=
es a
touch of genius - and a lot of courage to move in the opposite directio=
n."
Albert Einstein

=
