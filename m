Return-Path: <edjubenville@adelphia.net>
Received: from mta9.adelphia.net (mta9.adelphia.net [68.168.78.199])
	by ozlabs.org (Postfix) with ESMTP id B33CF67B32
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jul 2006 05:55:39 +1000 (EST)
From: "Edward Jubenville" <edjubenville@adelphia.net>
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>,
	"Matej Kupljen" <matej.kupljen@ultra.si>
Subject: RE: Slow boot with NFS, server not responding
Date: Wed, 26 Jul 2006 12:55:32 -0700
Message-ID: <GPECLCIGPLHEOMGPMCPAMEJEDNAA.edjubenville@adelphia.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <44C65097.2030601@ru.mvista.com>
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

Andrei wrote:
> Did you try using ethereal or tcpdump to see what is going on the wire?

I ran ethereal on the NFS server and on a PC connected to the same hub as
the target board highlighted the problem.  Many NFS READ REPLY messages from
the server were getting lost on their way to the target board.  The default
timeout was slow (about 1 second) so boot time was grossly extended.  The
packets were getting dropped by a Bay Networks switch.  Bypassing the switch
temporarily solved the problem, but I needed a more robust solution.

Matej wrote:
> We solved this by specifying additional kernel command line parameter:
>    nfsroot=,tcp
> which specifies that for the NFS TCP should be used instead of UDP.

I tried that, and the behavior changed only a little bit.  I would still get
the original error messages, but I would also get TCP checksum errors
reported.  I think the problematic switch was being overwhelmed.  I then
looked at other NFS mount arguments, and tried lowering read/write sizes to
fit into a single Ethernet packet.

I tried:
	nfsroot=...,rsize=1024,wsize=1024
and that fixed the problem!

Thanks for the help!

Ed Jubenville
