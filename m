Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 39E2ADE145
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 01:14:02 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC] [PATCH v2] MPC5121 TLB errata workaround
Date: Fri, 13 Mar 2009 15:16:55 +0100
References: <200903131121.00077.david.jander@protonic.nl>
	<200903131126.28662.david.jander@protonic.nl>
	<34B75591-5E9D-4966-BE06-9F4E48ED31B2@kernel.crashing.org>
In-Reply-To: <34B75591-5E9D-4966-BE06-9F4E48ED31B2@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903131516.56549.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Wolfgang Denk <wd@denx.de>, Gunnar Von Boehn <gunnar@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 13 March 2009 14:22:22 Kumar Gala wrote:
> 
> On Mar 13, 2009, at 5:26 AM, David Jander wrote:
> 
> >
> > Forgot to mention: The patch is based on denx git tree head  
> > 'ads5121', but
> > it should apply without problem (some offset at most) to mainline.
> >
> > Best regards,
> >
> 
> Out of interest did this version produce better performance on the  
> benchmarks than your v1 version?

Some examples:

1.- mplayer -nosound -benchmark testfile.mpeg (a DVD-mpeg2 file):

No fix at all:
VC: 30.5s VO: 53.4s Sys:1.95s Total: 85.8s

First fix (force writes to way 0):
VC: 24.3s VO: 40.6s Sys:1.95s Total: 66.9s

Complete fix (implementing lrw):
VC: 23.1s VO: 31.5s Sys:1.03s Total: 55.6s


2.- prboom -timedemo doombench1 (where doombench1.lmp is prerecorded demo):

No fix at all: 14.1 fps
First fix (force writes to way 0): 16.7 fps
Complete fix (implementing lrw): 18.1 fps


3.- Synthetic and pathologic memcpy() benchmark:
No fix at all: 26 Mbyte/s
First fix (force writes to way 0): 160 MByte/s
Complete fix (implementing lrw): 163 MByte/s

Note, that this benchmark should't really show any difference between v1 
and v2, since v1 is almost the best possible fix for copy's only.

Tell me if you know of some other interesting benchmarks to try.

Best regards,

-- 
David Jander
Protonic Holland.
