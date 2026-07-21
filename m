Return-Path: <linuxppc-dev+bounces-24564-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989A1C44515
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 00:46:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3zGv6VdDz2ySg;
	Tue, 21 Jul 2026 10:46:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784594807;
	cv=none; b=Dukcvd2qxwv9Av3vCqFtfo9DYqlgOMncJIGbk7kGJn7UuI15VJOpbbkOxli2U3gQHAyG2/HpIiQlWLXF+kly0432xIdjxiAWdjEl5JSdfXuJ7ZFUaAlrngoQTujLwaa8+LgGeWeIEhbBqR/h58ajQjqe+D1YN3T7F1cR8LbE4ij+I7aI1foZZEqW1cWpWX6yAshIS2U69ZK62VE7CmnuDSOLtmbX5qvrWqqp31g8Cy4ssId1XN/hojk1zBoEiAboFAika6dxz+17Zb6DT0GsSWzLFceQMH+/90PbUFAEBLl2mupnu42DQycVzBoSj7a7qLbMNowejx+OVRwaZgAxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784594807; c=relaxed/relaxed;
	bh=tyjDL6Bg5Az8j/9WD/q2xY+18VD/UjY4klZbAbgMCyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQu2A73davqcGSpzXND5b1+5efC4D40aZXyz4VPtrdDzOd7eAcUsQt4RSPMVHe/7rrO4OwrVuN1PTO75DtkYnpMJgPuZk/Qio3DmuCASeVuUu/PIYHYTpVuNqbQZhM1RJMTfYx2dYUyZPVYcWA9EpL3C1h4SVEXcOHyUbzkcjggQHTkChjZiCWaw/e5GACrXJQynK1EC7Yi4JjUz3DSES0USOLJbp+K6HfGqyVCmaTKukX/E8AoPnDDbsSmdO5U3wp36/7ZjcSZo6ldlPn4i8cicSv5xr/HdPQ1nqnuywMbz+w7wUJ92+fwAccXoCcTd4O8r29bqaRK/AMKAn/5KMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRALKiV1; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRALKiV1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3zGt5Zvrz2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 10:46:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AFC7A60A7C;
	Tue, 21 Jul 2026 00:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D126F1F000E9;
	Tue, 21 Jul 2026 00:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784594803;
	bh=tyjDL6Bg5Az8j/9WD/q2xY+18VD/UjY4klZbAbgMCyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QRALKiV1VD5gb2QhM2IPcwMj+gn7HrpVlL7pWf+8eMXlbzM92zGpgkmLyDEwfI+2E
	 2IhrNhDZByEdVlgO2elYvobfFvPlDd28sPPerSuQ1JVRs7GQa8HheTC3fZCTL9uf1U
	 j0/q1SR3h4QKIemZI4Arns3QHs3r8b3tlEnESLag93GeJNX3ZdX8M4/Pb4h+sA3VBx
	 wwiINJPHQiCKimKUDe6g83woVaahni1LTobSBkcbaiQHv4TJUZiVC3o4XqnHQq58um
	 FvwbHlZ01UP4ja5saK2H3FJAfHFoaaxDendp96P7BclXVqupbuO6jw9g/yuesCNcRv
	 JTO/tEiXBgrww==
Date: Tue, 21 Jul 2026 01:46:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, Dave Jiang
 <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>, Len Brown
 <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Robert Richter
 <rrichter@amd.com>, linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Alejandro Lucero
 <alucerop@amd.com>, Alison Schofield <alison.schofield@intel.com>, Ankit
 Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>, Ben Cheatham
 <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao
 <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio M . De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Gregory Price
 <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet
 <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Li Ming
 <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Oliver O'Halloran <oohall@gmail.com>,
 Shiju Jose <shiju.jose@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Smita Koralahalli
 <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC] cxl: Device protocol AER injection
Message-ID: <20260721014635.74d89853@jic23-huawei>
In-Reply-To: <62c40932-0f9c-4a67-8ff6-4bc7ba24f40e@amd.com>
References: <20260717225700.3543801-1-terry.bowman@amd.com>
	<20260720220430.30b7e3ef@jic23-huawei>
	<62c40932-0f9c-4a67-8ff6-4bc7ba24f40e@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > 
> > Why is this an RFC rather than a final proposal?  There should always
> > be something to give the reviewer that info in the patch description.
> > I'd actually be tempted to throw a cover letter in to have somewhere
> > out of the way to put that information.
> > 
> > Is it simply because it only makes sense once the other seris lands. 
> >   
> 
> The immediate priority was providing a testing procedure for the v18 series.
> I wasn't sure how the design would be received. For instance, the to_einj_ras_base() 
> could be moved into cxl-test as a to_ras_base() mock implemented function or 
> it could remain in ras.c (or maybe even ras_einj.c) outside of cxl-mock. I'm 
> looking forward to Alison's review and comments. 
> 
> My preference is to introduce core/ras_einj,c and add these changes. This 
> would be to isolate all the changes except for: cxl_ras_einj_init(), cxl_ras_einj_exit(), 
> and to_einj_ras_base(). I've started moving forward with making these changes 
> knowing the direction could change once this receives more reviews.
> 
> Also worth discussing is the commandline takes multiple parameters for
> a single sysfs file which I know isn't acceptable by everyone. I personally 
> like the interface as-is because its simpler to use in comparison to multiple 
> files that must be set individually.

It is debugfs so rules are much more flexible than sysfs.




> >> ---
> >>  drivers/cxl/Kconfig           |  13 +++
> >>  drivers/cxl/core/core.h       |  21 ++++
> >>  drivers/cxl/core/port.c       |   2 +-
> >>  drivers/cxl/core/ras.c        | 208 ++++++++++++++++++++++++++++++++++
> >>  drivers/cxl/core/ras_rch.c    |  12 ++
> >>  drivers/pci/pcie/aer_inject.c |  29 ++---
> >>  include/linux/aer.h           |  15 +++
> >>  7 files changed, 281 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> >> index 80aeb0d556bd7..ef449228b2549 100644
> >> --- a/drivers/cxl/Kconfig
> >> +++ b/drivers/cxl/Kconfig
> >> @@ -238,6 +238,19 @@ config CXL_RAS
> >>  	def_bool y
> >>  	depends on ACPI_APEI_GHES && PCIEAER && CXL_BUS
> >>  
> >> +config CXL_PROTO_AER_EINJ
> >> +	bool "CXL: RAS Protocol Error Injection using AER EINJ"
> >> +	depends on CXL_RAS
> >> +	depends on PCIEAER_INJECT  
> > 
> > Do we think anyone who has CXL and PCIEAER_INJECT support will want
> > to carefully not build this?  I'm just wondering if we can avoid asking
> > the question and base the built or not on the combination of those.
> >   
> 
> Good question: How do we incorporate this with the existing CXL EINJ 
> functionality making them complementary and consistant? The existing 
> EINJ is true ACPI injection but only supports RPs. The ACPI EINJ callouts 
> are currrently in core/port.c. We should consider moving it into a common file 
> such as core/ras_einj.c. With that move it will help force us merge the interfaces
> where/if possible and at least give central location for error RAS injection.
> I think folding the AER injection into PCIEAER_INJECT kernel config is 
> reasonable but looking for others feedback.
> 

I hadn't really thought about the injection method.  Indeed raises
interesting questions of how it should be done.  Add an ABI doc
in Documentation/ABI for next version.

> >   
> >> +static DEFINE_MUTEX(cxl_aer_einj_mutex);  
> > 
> > Needs a comment for what data it is protecting.
> >   
> >> +
> >> +struct cxl_aer_einj cxl_aer_einj = {
> >> +	.lock = &cxl_aer_einj_mutex,
> >> +};
> >> +
> >> +static const char cxl_aer_einj_usage[] =
> >> +	"ssss:bb:dd.f [UCE|CE] AER_STATUS RAS_STATUS [RCH]\n";
> >> +
> >> +static int cxl_aer_inject_error(struct pci_dev *pdev, bool correctable,
> >> +				u32 aer_status, u32 ras_status)
> >> +{
> >> +	/* RCD errors are signaled as internal errors on the associated RCEC */
> >> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END) {
> >> +		if (!pdev->rcec)
> >> +			return -ENODEV;
> >> +		pdev = pdev->rcec;
> >> +	}
> >> +
> >> +	struct aer_error_inj einj = {
> >> +		.bus = pdev->bus->number,
> >> +		.dev = PCI_SLOT(pdev->devfn),
> >> +		.fn = PCI_FUNC(pdev->devfn),
> >> +		.domain = pci_domain_nr(pdev->bus),
> >> +	};
> >> +	int ret;
> >> +	int aer_offset;
> >> +	int ras_offset;
> >> +
> >> +	if (correctable) {
> >> +		einj.cor_status = aer_status | PCI_ERR_COR_INTERNAL;
> >> +		aer_offset = PCI_ERR_COR_STATUS / sizeof(u32);
> >> +		ras_offset = CXL_RAS_CORRECTABLE_STATUS_OFFSET / sizeof(u32);  
> > 
> > Given these are offsets into cxl_aer_einj.aer_registers / ras_registers
> > can we use sizeof(*cxl_aer_einj.aer_registers) etc
> >   
> We could but that assumes the CEs are book ending the register blocks. And this would 
> be inconsistent with UCE case below, right? Tell me if I misunderstaood the question.

I just meant to replace those sizeof(u32) with something that indicates
where the size is coming from.  Applies equally below.


> >   
> >> +
> >> +static void __iomem *to_einj_ras_base(struct cxl_port *port, struct cxl_dport *dport)
> >> +{
> >> +	if (dport) {
> >> +		if (cxl_aer_einj.is_rch) {
> >> +			if (cxl_aer_einj.dev == dport->dport_dev) {
> >> +				cxl_aer_einj.dev = NULL;
> >> +				return (__force void __iomem *)cxl_aer_einj.ras_registers;  
> > 
> > Given the output of this is always force cast, maybe move that force up to the caller?
> >   
> 
> I think that works if it remains an internal helper and isn't made a mock function to to_ras_base(). 
> If to_einj_ras_base() is used as a mock than it would require changing the to_ras_base() 
> as well. 
> 
> >> +			}
> >> +		} else {
> >> +			if (cxl_aer_einj.dev == dport->dport_dev) {
> >> +				pci_dev_put(to_pci_dev(cxl_aer_einj.dev));  
> > 
> > Not locally obvious why a thing called to_einj_ras_base should put anything it didn't
> > get.  I think this needs a restructure to more obviously be tidying up references
> > that were held over the queue. At very leads needs a comment.
> > /* Reference held from X no longer needed so drop */
> >   
> 
> The ref was incremented in cxl_aer_einj_write() on invoking injection. The ref is 
> decremented here after its usage. RCHs are excluded because they dont have a SBDF.

Just add minimal reference for that.

> 
> >> +				cxl_aer_einj.dev = NULL;
> >> +				return (__force void __iomem *)cxl_aer_einj.ras_registers;
> >> +			}
>
> >> +	if (cxl_aer_einj.dev) {
> >> +		void __iomem *einj = to_einj_ras_base(port, dport);
> >> +		if (einj)
> >> +			return einj;
> >> +	}
> >> +#endif
> >> +
> >>  	if (dport)
> >>  		return dport->regs.ras;
> >>  
> >> @@ -458,10 +656,20 @@ void cxl_ras_init(void)
> >>  	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> >>  	cxl_register_proto_err_work(&cxl_proto_err_work,
> >>  				   cxl_proto_err_do_flush);
> >> +#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
> >> +	cxl_ras_create_debugfs(cxl_debugfs);  
> > stub that in a header.
> >   
> 
> Actually, during rework today I moved it to cxl_ras_einj_init(),
> a new function. Thoughts?

Sounds good.

> >> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> >> index 09bfc7194ef31..b313adef680ae 100644
> >> --- a/drivers/pci/pcie/aer_inject.c
> >> +++ b/drivers/pci/pcie/aer_inject.c
> >> @@ -14,6 +14,7 @@
> >>  
> >>  #define dev_fmt(fmt) "aer_inject: " fmt
> >>  
> >> +#include <linux/aer.h>
> >>  #include <linux/module.h>
> >>  #include <linux/init.h>
> >>  #include <linux/interrupt.h>
> >> @@ -31,19 +32,6 @@
> >>  static bool aer_mask_override;
> >>  module_param(aer_mask_override, bool, 0);
> >>  
> >> -struct aer_error_inj {
> >> -	u8 bus;
> >> -	u8 dev;
> >> -	u8 fn;
> >> -	u32 uncor_status;
> >> -	u32 cor_status;
> >> -	u32 header_log0;
> >> -	u32 header_log1;
> >> -	u32 header_log2;
> >> -	u32 header_log3;
> >> -	u32 domain;
> >> -};
> >> -
> >>  struct aer_error {
> >>  	struct list_head list;
> >>  	u32 domain;
> >> @@ -316,7 +304,7 @@ static int pci_bus_set_aer_ops(struct pci_bus *bus)
> >>  	return 0;
> >>  }
> >>  
> >> -static int aer_inject(struct aer_error_inj *einj)
> >> +int aer_inject(struct aer_error_inj *einj)
> >>  {
> >>  	struct aer_error *err, *rperr;
> >>  	struct aer_error *err_alloc = NULL, *rperr_alloc = NULL;
> >> @@ -332,10 +320,14 @@ static int aer_inject(struct aer_error_inj *einj)
> >>  	dev = pci_get_domain_bus_and_slot(einj->domain, einj->bus, devfn);
> >>  	if (!dev)
> >>  		return -ENODEV;
> >> -	rpdev = pcie_find_root_port(dev);
> >> -	/* If Root Port not found, try to find an RCEC */
> >> -	if (!rpdev)
> >> -		rpdev = dev->rcec;
> >> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)   
> > 
> > { }
> > as the else is multiline (see coding standard)
> >   
> 
> Ok
> 
> > Maybe need a comment for why it might be an RCEC for injection.
> > Is this an RCH specific path where there is nothing else to target?
> >   
> >> +		rpdev = dev;
> >> +	else {
> >> +		rpdev = pcie_find_root_port(dev);
> >> +		/* If Root Port not found, try to find an RCEC */
> >> +		if (!rpdev)
> >> +			rpdev = dev->rcec;
> >> +	}
> >>  	if (!rpdev) {
> >>  		pci_err(dev, "Neither Root Port nor RCEC found\n");
> >>  		ret = -ENODEV;
> >> @@ -482,6 +474,7 @@ static int aer_inject(struct aer_error_inj *einj)
> >>  	pci_dev_put(dev);
> >>  	return ret;
> >>  }
> >> +EXPORT_SYMBOL_GPL(aer_inject);  
> > I wonder if we want to restrict this to specific modules?
> > 
> > One for Bjorn probably.
> >   
> Because right now it injects AER to any PCI device. 
> 
> Also, worth discussing is the commandline currently uses multiple parameters for
> a single sysfs file. I mentioned this at the top.
> 
> 
> Thanks for reviewing Jonathan.
> 
> -Terry

> 


