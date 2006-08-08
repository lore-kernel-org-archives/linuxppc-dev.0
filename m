Return-Path: <cdumoulin@ics-ltd.com>
Received: from mx6-1.spamtrap.magma.ca (mx6-1.spamtrap.magma.ca
	[209.217.78.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A78DB67A3D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 07:00:48 +1000 (EST)
Received: from mail4.magma.ca (mail4.internal.magma.ca [10.0.10.14])
	by mx6-1.spamtrap.magma.ca (8.13.1/8.13.1) with ESMTP id k78L0hwx013913
	for <linuxppc-embedded@ozlabs.org>; Tue, 8 Aug 2006 17:00:43 -0400
Received: from ics-ltd.com ([64.26.174.130]) (authenticated bits=0)
	by mail4.magma.ca (Magma's Mail Server) with ESMTP id k78L0h3S024491
	for <linuxppc-embedded@ozlabs.org>; Tue, 8 Aug 2006 17:00:44 -0400
Message-ID: <44D8FB80.6060601@ics-ltd.com>
Date: Tue, 08 Aug 2006 17:00:48 -0400
From: Christopher Dumoulin <cdumoulin@ics-ltd.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: "Function not implemented" error with syslogd
References: <44D89695.1050501@ics-ltd.com>
In-Reply-To: <44D89695.1050501@ics-ltd.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I figured out the problem I was having. I had to enable "Networking 
support", and "Unix domain sockets" in my kernel configuration in order 
for sockets to work.

- Chris

Christopher Dumoulin wrote:

> Hi All,
> I've got an embedded linux system running on a V2Pro-based devlopment 
> board, using a 2.6 kernel and ramdisk based on ELDK 4.0.
> I'm trying to get syslogd running so I can log printk output to 
> /var/log/messages. I'm using a Busybox syslogd that was included in 
> the ELDK 4.0 ramdisk image. When I try to start syslogd, I get the 
> following error:
> syslogd: Couldn't get file descriptor for socket /dev/log: Function 
> not implemented
>
> The file /dev/log didn't exist, so I tried to create it with the 
> following command, but that doesn't seem to make a difference:
> mknod -m 660 /dev/log p
>
> I'm assuming that syslogd does a 'socket' call, which is returning 
> ENOSYS. Any ideas about what is going on, or how I can get it working, 
> would be appreciated.
>
> Regards,
> Chris Dumoulin



-- 
*--Christopher Dumoulin--*
Software Team Leader

<http://ics-ltd.com/>
<http://ics-ltd.com/>

Interactive Circuits and Systems Ltd.
5430 Canotek Road
Ottawa, ON
K1J 9G2
(613)749-9241
1-800-267-9794 (USA only)

------------------------------------------------------------------------
This e-mail is private and confidential and is for the addressee only. 
If misdirected, please notify us by telephone and confirm that it has 
been deleted from your system and any hard copies destroyed. You are 
strictly prohibited from using, printing, distributing or disseminating 
it or any information contained in it save to the intended recipient.
