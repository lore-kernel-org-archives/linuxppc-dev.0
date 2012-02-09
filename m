Return-Path: <bhelgaas@google.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CBF27B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 06:25:10 +1100 (EST)
Received: by wibhj6 with SMTP id hj6so1561448wib.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Feb 2012 11:25:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1328738567.2903.45.camel@pasglop>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
 <1328425088-6562-10-git-send-email-yinghai@kernel.org>
 <CAErSpo6BwznWf3rq4J2Ao+rrgR4yWqQ0mQGygkd2KmBuA1OD8g@mail.gmail.com>
 <1328738567.2903.45.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 9 Feb 2012 11:24:45 -0800
Message-ID: <CAErSpo7ekGn-+Mnyz7KL=fVFH3Ed19AeE3MKkZWJ4bd0Jo7kCw@mail.gmail.com>
Subject: Re: [PATCH 09/24] PCI, powerpc: Register busn_res for root buses
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Yinghai Lu <yinghai@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>,
 Paul Mackerras <paulus@samba.org>, Jesse Barnes <jbarnes@virtuousgeek.org>,
 linux-pci@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 8, 2012 at 2:02 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2012-02-08 at 07:58 -0800, Bjorn Helgaas wrote:
>> The only architecture-specific thing here is discovering the range of
>> bus numbers below a host bridge. =A0The architecture should not have to
>> mess around with pci_bus_update_busn_res_end() like this. =A0It should
>> be able to say "here's my bus number range" (and of course the PCI
>> core can default to 0-255 if the arch doesn't supply a range) and the
>> core should take care of the rest.
>
> So it's a bit messy in here because we deal with several things.
>
> What the firmware gives us is the range it assigned, but that isn't
> necessarily the HW limits (almost never is in fact).
>
> In some cases we honor it, for example when in "probe only" mode where
> we prevent any reassigning, and in some case, we ignore it and let the
> PCI core renumber things (typically because the FW "forgot" to set aside
> bus numbers for a cardbus slot for example, that sort of things).
>
> So it's a bit of a tricky situation.
>
> Off the top of my head, I'm pretty sure that most if not all of our PCI
> host bridges simply support a full 0...255 range and there is no sharing
> between bridges like on x86, they are just different domains.

My point is that the interface between the arch and the PCI core
should be simply the arch telling the core "this is the range of bus
numbers you can use."  If the firmware doesn't give you the HW limits,
that's the arch's problem.  If you want to assume 0..255 are
available, again, that's the arch's decision.

But the answer to the question "what bus numbers are available to me"
depends only on the host bridge HW configuration.  It does not depend
on what pci_scan_child_bus() found.  Therefore, I think we can come up
with a design where pci_bus_update_busn_res_end() is unnecessary.

Bjorn
