Return-Path: <happyphot@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.205])
	by ozlabs.org (Postfix) with ESMTP id 0899E68972
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jan 2006 01:10:46 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id j2so2805316nzf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 06 Jan 2006 06:10:45 -0800 (PST)
Message-ID: <002e01c612ca$f7614a80$0760120a@photon>
From: "HappyPhot" <happyphot@gmail.com>
To: "David Jander" <david.jander@protonic.nl>
References: <000701c60fab$9fdca6a0$0760120a@photon>
	<200601031410.55884.david.jander@protonic.nl>
	<004701c611a8$557dbf00$0760120a@photon>
	<200601050852.45616.david.jander@protonic.nl>
Date: Fri, 6 Jan 2006 22:09:53 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"; reply-type=original
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: VFS: Cannot open root device "31:03" or unknown-block(31,3)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> in your .config:
>
>> CONFIG_JFFS2_FS=m
>
> This is wrong. You have to choose "y", not "m" (for module).
> This way jffs2 is compiled as a module. That means, that jffs2 filesystem 
> will
> not be available until the module is loaded with "insmod jffs2" of 
> something
> similar. That in turn means that your system has to start up first in 
> order
> to be able to do this, but since you can't start because your root 
> filesystem
> is on jffs2, you have created yourself a "chicken and egg" problem.
> If you choose "y" then jffs2 support will be compiled into the kernel, and
> thus be available before booting.

Hi, David,
  Yes, you are right. After changing it to 'y', the " VFS: Cannot open 
root..."
message was gone. I'm so happy and thank you very much.

  Now it is another problem again. (something like: Oops: kernel access of 
bad
area. sig:11...).  I am going to check what happened.

>
> In your bootlog:
>
>> Linux version 2.6.14.2 (happy@sddlinux1) (gcc version 3.3.3 (DENX ELDK 
>> 3.1.1
>> 3.3.3-10)) #29 Sun Jan 1 22:34:28 CST 2006
>> Motorola SPS Sandpoint Test Platform
>
> I see you are using DENX ELDK 3.1.1 and a kernel which AFAIK is not 
> supported
> by this version of ELDK. Are you sure this is supposed to work? It 
> probably
> will, but I don't know what the "Sandpoint" is (it looks like a PowerPC
> processor of the MPC7xx series to me), so I couldn't tell.

  Do you know where to get the infomation about which kernel version it 
supports?

thank you,
/HappyPhot
