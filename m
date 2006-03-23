Return-Path: <hbabu@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA9BE67A76
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 12:54:49 +1100 (EST)
Received: from e31.co.us.ibm.com (e31.boulder.ibm.com [9.17.249.41])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id k2NN2alW025791
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Mar 2006 18:02:37 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2NN2EpL014861
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Mar 2006 18:02:14 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2NMxBSd231976
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Mar 2006 15:59:11 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2NN2DZW013342
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Mar 2006 16:02:14 -0700
In-Reply-To: <20060323201258.GA5538@pb15.lixom.net>
To: Olof Johansson <olof@lixom.net>
MIME-Version: 1.0
Subject: Re: [PATCH] kdump: Fix for machine checkstop on DMA fault
Message-ID: <OF587D6284.5AECD8A6-ON8725713A.007B0F39-8825713A.007E8BA3@us.ibm.com>
From: Haren Myneni <hbabu@us.ibm.com>
Date: Thu, 23 Mar 2006 15:06:22 -0800
Content-Type: multipart/alternative;
	boundary="=_alternative 007E8B9D8825713A_="
Cc: Milton Miller <miltonm@bga.com>, Michael Ellerman <michael@ellerman.id.au>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Olaf Hering <olh@suse.de>, ellerman@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 007E8B9D8825713A_=
Content-Type: text/plain; charset="US-ASCII"

linuxppc-dev-bounces+hbabu=us.ibm.com@ozlabs.org wrote on 03/23/2006 
12:12:58 PM:

> On Thu, Mar 23, 2006 at 12:19:04AM -0600, Olof Johansson wrote:
> 
> > The crash kernel needs to be even more careful, and instead read out
> > the entries that are mapped and reserve them. This would require a bit
> > more plumbing since there's no way to read an entry right now, but 
it'd
> > remove that hole.
> 
> Actually, what's probably easier is to allocate some entries when the
> purgatory is set up, and make the crash kernel only use those by 
modifying
> the device tree accordingly. Sort of how regular memory is handled right
> now. That'd be a cleaner solution with less changes needed.
> 
> The trick will be to get a decent size contiguous allocation, but the
> same applies for the memory reserve.

Olof, Thanks for your comments/suggestions.

On JS21, immediately after the tce entries are initialized, the machine 
checkstops with an error "Internal CPU 1 Fault Error" on bladecenter MM. 
If we do not initialize tce entries for crash kernel, allows the ongoing 
DMA continue to the old kernel memory. I though that, ongoing DMA will be 
stopped when the device reset happens later by the drivers. I think, some 
hardening is already included in some drivers to take care of this 
behavior. I might be wrong. So far, I had e100 issue after testing on p5, 
p4, js20 and js21. Probably, it could be lucky scenario.
So, will be keeping the same change (posted here) plus your suggestion. 
Right? Can we apply same approach even for power-4?

Thanks
Haren




> 
> 
> -Olof
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

--=_alternative 007E8B9D8825713A_=
Content-Type: text/html; charset="US-ASCII"


<br>
<br><font size=2><tt>linuxppc-dev-bounces+hbabu=us.ibm.com@ozlabs.org wrote
on 03/23/2006 12:12:58 PM:<br>
<br>
&gt; On Thu, Mar 23, 2006 at 12:19:04AM -0600, Olof Johansson wrote:<br>
&gt; <br>
&gt; &gt; The crash kernel needs to be even more careful, and instead read
out<br>
&gt; &gt; the entries that are mapped and reserve them. This would require
a bit<br>
&gt; &gt; more plumbing since there's no way to read an entry right now,
but it'd<br>
&gt; &gt; remove that hole.<br>
&gt; <br>
&gt; Actually, what's probably easier is to allocate some entries when
the<br>
&gt; purgatory is set up, and make the crash kernel only use those by modifying<br>
&gt; the device tree accordingly. Sort of how regular memory is handled
right<br>
&gt; now. That'd be a cleaner solution with less changes needed.<br>
&gt; <br>
&gt; The trick will be to get a decent size contiguous allocation, but
the<br>
&gt; same applies for the memory reserve.</tt></font>
<br>
<br><font size=2><tt>Olof, Thanks for your comments/suggestions.</tt></font>
<br>
<br><font size=2><tt>On JS21, immediately after the tce entries are initialized,
the machine checkstops with an error &quot;Internal CPU 1 Fault Error&quot;
on bladecenter MM. If we do not initialize tce entries for crash kernel,
allows the ongoing DMA continue to the old kernel memory. I though that,
ongoing DMA will be stopped when the device reset happens later by the
drivers. I think, some hardening is already included in some drivers to
take care of this behavior. I might be wrong. So far, I had e100 issue
after testing on p5, p4, js20 and js21. Probably, it could be lucky scenario.</tt></font>
<br><font size=2><tt>So, will be keeping the same change (posted here)
plus your suggestion. Right? Can we apply same approach even for power-4?</tt></font>
<br>
<br><font size=2><tt>Thanks</tt></font>
<br><font size=2><tt>Haren</tt></font>
<br>
<br>
<br>
<br><font size=2><tt><br>
&gt; <br>
&gt; <br>
&gt; -Olof<br>
&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; Linuxppc-dev@ozlabs.org<br>
&gt; https://ozlabs.org/mailman/listinfo/linuxppc-dev<br>
</tt></font>
--=_alternative 007E8B9D8825713A_=--
