Subject: Re: 750 and Discovery II coherency with PCI....
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <410F05EC.1040405@realitydiluted.com>
References: <410F05EC.1040405@realitydiluted.com>
Content-Type: text/plain
Message-Id: <1091580163.1922.39.camel@gaston>
Mime-Version: 1.0
Date: Wed, 04 Aug 2004 10:42:44 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2004-08-03 at 13:26, Steven J. Hill wrote:
> Greetings.
>
> I am writing a device driver for a PMC card that is nothing
> fancy. It is not a PCI-X card though. My Linux driver properly
> detects the device, 'ioremaps' the PCI IO and MEM regions then
> attempts to start writing the devices registers for setup
> and configuration. I am not getting valid reads and there
> appears to be some coherency issues. I have verified that no
> other drivers or resources in the system are utilizing the
> addresses that are returned to me from 'ioremap'. I have the
> following code snippet:

There is no coherency issues with non cacheable (ioremap'ed)
access of that kind... Note that if you are dealing with IO space,
then you should use inX/outX accessors and not ioremap.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
