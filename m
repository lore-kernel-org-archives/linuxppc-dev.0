Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id D425EDDFAD
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 01:30:50 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC][PATCH v4] MPC5121 TLB errata workaround
Date: Mon, 16 Mar 2009 15:30:48 +0100
References: <200903161521.04979.david.jander@protonic.nl>
In-Reply-To: <200903161521.04979.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903161530.48649.david.jander@protonic.nl>
Cc: Paul Mackerras <paulus@samba.org>, Gunnar Von Boehn <gunnar@genesi-usa.com>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Ooops, ok I think I just missed your proposal, Kumar.

Anyway, I'll post my benchmark results to this here:

1.- mplayer -nosound -benchmark testfile.mpeg (a DVD-mpeg2 file):

No fix at all:
VC: 30.5s VO: 53.4s Sys:1.95s Total: 85.8s

First fix (force writes to way 0):
VC: 24.3s VO: 40.6s Sys:1.95s Total: 66.9s

Second fix (implementing lrw):
VC: 23.1s VO: 31.5s Sys:1.03s Total: 55.6s

Third fix (patch v4, lrw in SPRG6):
VC: 21.055s VO: 28.289s Sys:0.972s Total: 50.316s



2.- prboom -timedemo doombench1 (where doombench1.lmp is prerecorded demo):

No fix at all: 14.1 fps
First fix (force writes to way 0): 16.7 fps
Second fix (implementing lrw): 18.1 fps
Third fix (patch v4, lrw in SPRG6): 19.9 fps



3.- Synthetic and pathologic memcpy() benchmark:
No fix at all: 26 Mbyte/s
First fix (force writes to way 0): 160 MByte/s
Second fix (implementing lrw): 163 MByte/s
Third fix (patch v4, lrw in SPRG6): 180 MByte/s


Best regards,

-- 
David Jander
Protonic Holland.
