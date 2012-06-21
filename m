Return-Path: <bhelgaas@google.com>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8920CB6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2012 10:20:34 +1000 (EST)
Received: by lban1 with SMTP id n1so1230237lba.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2012 17:20:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1340051997.2372.27.camel@pasglop>
References: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
 <1338959744.7150.153.camel@pasglop>
 <CAErSpo4pDOigbvF3SPzOUqx79d_-8yHWrc8TsWChG9indB+k_A@mail.gmail.com>
 <1340051997.2372.27.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 20 Jun 2012 18:20:08 -0600
Message-ID: <CAErSpo5D60_bD2v99itVgXrqyjvFGAg-tPggfJTJbATE1f0_YQ@mail.gmail.com>
Subject: Re: [PATCH] PPC: PCI: Fix pcibios_io_space_offset() so it works for
 32-bit ptr/64-bit rsrcs
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@au1.ibm.com>,
 Ben Collins <ben.c@servergy.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 18, 2012 at 2:39 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2012-06-18 at 09:23 -0600, Bjorn Helgaas wrote:
>> Ooh, sorry about that. =A0Who's going to push this fix? =A0I don't see i=
t
>> in Linus' tree yet. =A0If you want me to, please forward me the original
>> patch.
>
> I want to double check something. We are still printing something wrong
> in the kernel log, so it looks like we have some incorrect carry in some
> arithmetic happening somewhere.

Probably not related to whatever you're seeing, but just FYI, I think
the core has a sign-extension bug related to P2P bridge I/O windows:

http://marc.info/?l=3Dlinux-pci&m=3D134023801524895&w=3D2
