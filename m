Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D560BC6786E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 12:37:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3266C2084D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 12:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3266C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hNmX4lqWzF3Hg
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 23:37:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hNjX3DYDzF3H2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 23:34:39 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DAD11AE88;
 Fri, 26 Oct 2018 12:34:35 +0000 (UTC)
Date: Wed, 24 Oct 2018 08:22:51 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: ethernet "bus" number in DTS ?
Message-ID: <20181024082239.5ee41017@naga.suse.cz>
In-Reply-To: <8225ba9e-ce8f-b0e0-8f3d-73783693eea4@gmail.com>
References: <88328977dfeaf667a98d791074b721fe730d285b.camel@infinera.com>
 <518e0cf1-ef7e-b251-a153-34e01a80267d@gmail.com>
 <694b6f4f6b66eb35176e3eb48bbec474c9647007.camel@infinera.com>
 <8225ba9e-ce8f-b0e0-8f3d-73783693eea4@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 23 Oct 2018 11:20:36 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 10/23/18 11:02 AM, Joakim Tjernlund wrote:
> > On Tue, 2018-10-23 at 10:03 -0700, Florian Fainelli wrote:  

> > 
> > I also noted that using status = "disabled" didn't work either to
> > create a fix name scheme. Even worse, all the eth I/F after gets
> > renumbered. It seems to me there is value in having stability in
> > eth I/F naming at boot. Then userspace(udev) can rename if need be. 
> > 
> > Sure would like to known more about why this feature is not wanted ?
> > 
> > I found
> >   https://patchwork.kernel.org/patch/4122441/
> > You quote policy as reason but surely it must be better to
> > have something stable, connected to the hardware name, than
> > semirandom naming?  
> 
> If the Device Tree nodes are ordered by ascending base register
> address, my understanding is that you get the same order as far as
> platform_device creation goes, this may not be true in the future if
> Rob decides to randomize that, but AFAICT this is still true. This
> may not work well with status = disabled properties being inserted
> here and there, but we have used that here and it has worked for as
> far as I can remember doing it.

So this is unstable in several respects. First is changing the
enabled/disabled status in the deivecetrees provided by the kernel.

Second is if you have hardware hotplug mechanism either by firmware or
by loading device overlays.

Third is the case when the devicetree is not built as part of the
kernel but is instead provided by firmware that initializes the
low-level hardware details. Then the ordering by address is not
guaranteed nor is that the same address will be used to access the same
interface every time. There might be multiple ways to configure the
hardware depending on firmware configuration and/or version.

 
> Second, you might want to name network devices ethX, but what if I
> want to name them ethernetX or fooX or barX? Should we be accepting a
> mechanism in the kernel that would allow someone to name the
> interfaces the way they want straight from a name being provided in
> Device Tree?

Clearly if there is text Ethernet1 printed above the Ethernet port we
should provide a mechanism to name the port Ethernet1 by default.

> 
> Aliases are fine for providing relative stability within the Device
> Tree itself and boot programs that might need to modify the Device
> Tree (e.g: inserting MAC addresses) such that you don't have to
> encode logic to search for nodes by compatible strings etc. but
> outside of that use case, it seems to me that you can resolve every
> naming decision in user-space.

However, this is pushing platform-specific knowledge to userspace. The
way the Ethernet interface is attached and hence the device properties
usable for identifying the device uniquely are platform-specific. 

On the other hand, aliases are universal when provided. If they are
good enough to assign a MAC address they are good enough to provide a
stable default name.

I think this is indeed forcing the userspace to reinvent several wheels
for no good reason.

What is the problem with adding the aliases?

Thanks

Michal
