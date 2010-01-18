Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 97420B7C94
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 04:38:34 +1100 (EST)
Received: by yxe8 with SMTP id 8so1005972yxe.17
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jan 2010 09:38:33 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1263434836.724.317.camel@pasglop>
References: <4B4DE58D.10008@petalogix.com> <1263434836.724.317.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 18 Jan 2010 10:38:13 -0700
Message-ID: <fa686aa41001180938k4033bffele6702acfac4a7cd2@mail.gmail.com>
Subject: Re: xilinx-pci driver and pci in general
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	thunderbird2k@gmx.net, LKML <linux-kernel@vger.kernel.org>,
	michal.simek@petalogix.com, John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 13, 2010 at 7:07 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2010-01-13 at 16:23 +0100, Michal Simek wrote:
>
>> The main problems are:
>> ppc use ppc_md struct which we don't have it on Microblaze.
>> xilinx-pci driver uses exclude_device function. This function is used in
>> indirect_pci.c too. There could be a way to move that function directly
>> to pci_controller structure which could be useful for other controllers
>> too. What do you think?
>>
>> Then there are some other ppc_md. calling like pcibios_after_init which
>> if I see correctly not used for ppc too.
>
> We may not be using after_init() anymore in which case you are welcome
> to send a patch to remove it :-)
>
> As for the others, well ... maybe you can do wrappers for these that
> call into ppc_md. on powerpc and into some kind of arch_pci_ops. that
> the platform provides on microblaze ?

I agree.  Replace the direct ppc_md. references with arch-provided wrappers.

>> Files contains CONFIG_PPC_OF and we would like to use only CONFIG_OF.
>> I remember any discuss around but not sure what was the conclusion on
>> powerpc.
>
> I think that should be allright, Grant, any objection there ?

None whatsoever.

>> Part of headers are the same that's why there will be a space to move
>> them to asm-generic.
>
> If you can convince other archs that it makes sense to do so ? :-)

Arnd can give you good advice here I think.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
