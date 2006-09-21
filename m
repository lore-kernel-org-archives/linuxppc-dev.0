Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s35.bay0.hotmail.com (bay0-omc3-s35.bay0.hotmail.com
	[65.54.246.235]) by ozlabs.org (Postfix) with ESMTP id 8359967BC2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 18:13:49 +1000 (EST)
Message-ID: <BAY110-F22CD47F1D256D56E8BEEF5B2200@phx.gbl>
In-Reply-To: <451168F6.3030701@ovro.caltech.edu>
From: "Ming Liu" <eemingliu@hotmail.com>
To: dwh@ovro.caltech.edu, jdub@us.ibm.com
Subject: Re: how an application program utilizes the driver.
Date: Thu, 21 Sep 2006 08:13:43 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Dave and Josh,
Thanks so much for your suggestion first.

Yes, it looks that I am really a beginner and there are so many points I 
cannot understand well. So I will follow your suggestions and go through 
those material first...

In fact, I am reading LDD3 now. However, it seems that the book is mainly 
focused on the driver part and there is not some chapter to tell how apps 
work with drivers. So after a rough glance, I still have much confusion. :(

I will read more to understand this topic. Thanks for your help again.

Regards
Ming


>From: David Hawkins <dwh@ovro.caltech.edu>
>To: Ming Liu <eemingliu@hotmail.com>
>CC: linuxppc-embedded@ozlabs.org
>Subject: Re: how an application program utilizes the driver.
>Date: Wed, 20 Sep 2006 09:14:46 -0700
>
>Hi Ming,
>
> > My situation is: I want to write a driver for my custom device.(In the
> > driver there are some functions defined to read or write my device.) 
Then
> > in my application program, I use these defined functions to operate my
> > hardware device. I think this is a normal process to operate the 
hardware
> > with driver+app, right?
>
>Right, but you've missed a few critical points.
>
>For your custom device, you'll create a driver that implements
>*kernel space* functions my_driver_open(), read(), write(), close()
>etc. You'll install that module and create an appropriate
>device node, eg. /dev/my_driver.
>
>In your *user-space* application code, you'll open that device
>
>int main(argc, argv) ...
>
>   int fd = open("/dev/my_driver" ...)
>
>
>and then write to your device ...
>
>   int write(fd, buffer, len);
>
>or read from your device ...
>
>   int read(fd, buffer, len);
>
>The user-space calls open, read, write eventually call down into
>your driver space code. The driver and application are not
>linked, they communicate via the /dev interface.
>
>You really should read through Linux Device Drivers by Rubini,
>or check out a tutorial such as
>
>http://www.ovro.caltech.edu/~dwh/correlator/pdf/LNX-723-Hawkins.pdf
>http://www.ovro.caltech.edu/~dwh/correlator/software/driver_design.tar.gz
>http://www.ovro.caltech.edu/~dwh/correlator/index.html
>
>Regards,
>Dave
>
>
>
>
>
>

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
