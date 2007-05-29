Return-Path: <bwarren@qstreams.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id A3FABDE0F3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 May 2007 00:52:24 +1000 (EST)
Subject: Re: Kernel 2.6, ML403, rootfs on nfs, gigabit ethernet link, nfs
	mount problems
From: Ben Warren <bwarren@qstreams.com>
To: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
In-Reply-To: <BAY115-W173A643AF082D78122CB6DB22F0@phx.gbl>
References: <BAY115-W173A643AF082D78122CB6DB22F0@phx.gbl>
Content-Type: text/plain
Date: Tue, 29 May 2007 10:52:21 -0400
Message-Id: <1180450341.29755.48.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Mohammad,

On Tue, 2007-05-29 at 14:41 +0000, Mohammad Sadegh Sadri wrote:
> Hi all,
> 
> well I could bring up the grant's kernel on ml403 completely. the root file system was over nfs. 
> 
> when I use a 100mbits link for connection to ml403 , every thing is working suitably.
> but when I use a 1000mbits link, I see that ml403 gets ip address from dhcp and mounts the root file system but can not go further , it stops with a message: "nfs server not responding ...." some thing like this.
> 
> when pinging to ml403 with 64 bytes packets, ping works fine for both of 100 and 1000mbits links
> but when I try to ping the board with 4000 bytes packets I notice that ml403 on gigabit link can not answer to ping packets, however on 100mbit link every thing works just fine.
> 
> any ideas?

NFS is notorious for sending lots of big packets one right after
another.  This can easily overwhelm an Ethernet receiver.  Until you're
able to figure out why the 1000M link can't keep up, limit the NFS
receive packet sizes by passing the following NFS option in your kernel
command line:

rsize=1024

You can experiment with the value.  I believe the NFS default size is
typically 8kB or greater.

regards,
Ben
