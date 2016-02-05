Return-Path: <jthumshirn@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E33701A006F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 19:34:18 +1100 (AEDT)
Date: Fri, 5 Feb 2016 09:34:13 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, JBottomley@odin.com,
 linux-kernel@vger.kernel.org, hare@suse.de,
 brking@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/6] ibmvscsi: Remove unsupported host config MAD and
 sysfs interface
Message-ID: <20160205083413.GF27969@c203.arch.suse.de>
References: <1454542114-1797-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1454542114-1797-6-git-send-email-tyreld@linux.vnet.ibm.com>
 <20160204080317.GT27969@c203.arch.suse.de>
 <56B38EE7.6060102@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <56B38EE7.6060102@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 04, 2016 at 09:48:23AM -0800, Tyrel Datwyler wrote:
> On 02/04/2016 12:03 AM, Johannes Thumshirn wrote:
> > On Wed, Feb 03, 2016 at 05:28:33PM -0600, Tyrel Datwyler wrote:
> >> A VIOSRP_HOST_CONFIG_TYPE management datagram (MAD) has existed in
> >> the code for some time. From what information I've gathered from
> >> Brian King this was likely implemented on the host side in a SLES 9
> >> based VIOS, which is no longer supported anywhere. Further, it is
> >> not defined in PAPR or supported by any AIX based VIOS.
> >>
> >> Treating as bit rot and removing the sysfs interface and associated
> >> host config code accordingly.
> > 
> > Doesn't removing a sysfs interface potentially break userspace code?
> > 
> 
> In the general case yes, but I feel in this case no. First, Reading from
> this config attribute of a vscsi host adapter always returns nothing.
> Second, any userspace code using this attribute better be checking for
> the existence of config. Just a quick look for
> /sys/class/scsi_host/host*/config under other host adapters on my system
> I find that attribute doesn't exist for any of them.
> 
> If there is truly enough concern that somebody may actually be accessing
> this useless attribute from userspace then we can still strip out the
> unsupported code, but leave the attribute and return nothing directly
> from the show function.

Which is what I kinda prefer. Slowly deprecate and phase out, but don't break
userspace. You never know who is writing some obscure piece of code relaying on
some sysfs attribute.

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
