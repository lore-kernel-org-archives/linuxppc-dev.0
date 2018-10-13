Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B150BC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 12:10:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2167420645
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 12:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2167420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XNnw5W65zF3Bl
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 23:10:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XNlJ1GPYzDrP2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 23:08:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42XNlH3YcWz9s9J;
 Sat, 13 Oct 2018 23:08:27 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dan Williams <dan.j.williams@intel.com>,
 Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/pseries: Add driver for PAPR SCM regions
In-Reply-To: <CAPcyv4jhs9f2DdOk30KU9___mWMtowQi0LP-OD1E+_5xFbxWgA@mail.gmail.com>
References: <20181010060812.20068-1-oohall@gmail.com>
 <20181010060812.20068-3-oohall@gmail.com>
 <CAPcyv4jhs9f2DdOk30KU9___mWMtowQi0LP-OD1E+_5xFbxWgA@mail.gmail.com>
Date: Sat, 13 Oct 2018 23:08:26 +1100
Message-ID: <87h8hq122t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dan Williams <dan.j.williams@intel.com> writes:
> On Tue, Oct 9, 2018 at 11:21 PM Oliver O'Halloran <oohall@gmail.com> wrote:
>>
>> Adds a driver that implements support for enabling and accessing PAPR
>> SCM regions. Unfortunately due to how the PAPR interface works we can't
>> use the existing of_pmem driver (yet) because:
>>
...
>> +
>> +static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>> +{
>> +       struct device *dev = &p->pdev->dev;
>> +       struct nd_mapping_desc mapping;
>> +       struct nd_region_desc ndr_desc;
>> +       unsigned long dimm_flags;
>> +
>> +       p->bus_desc.ndctl = papr_scm_ndctl;
>> +       p->bus_desc.module = THIS_MODULE;
>> +       p->bus_desc.of_node = p->pdev->dev.of_node;
>> +       p->bus_desc.attr_groups = bus_attr_groups;
>> +       p->bus_desc.provider_name = kstrdup(p->pdev->name, GFP_KERNEL);
>> +
>> +       if (!p->bus_desc.provider_name)
>> +               return -ENOMEM;
>> +
>> +       p->bus = nvdimm_bus_register(NULL, &p->bus_desc);
>> +       if (!p->bus) {
>> +               dev_err(dev, "Error creating nvdimm bus %pOF\n", p->dn);
>> +               return -ENXIO;
>> +       }
>> +
>> +       dimm_flags = 0;
>> +       set_bit(NDD_ALIASING, &dimm_flags);
>> +
>> +       p->nvdimm = nvdimm_create(p->bus, p, papr_scm_dimm_groups,
>> +                               dimm_flags, PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
>
> Looks good, although I'm just about to push out commits that change
> this function signature to take a 'security_ops' pointer. If you need
> a stable branch to base this on, let me know.
...
>
> Other than that looks ok to me:
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
>
> ...just the matter of what to do about function signature change.

Yeah that's a bit of a bother.

The ideal for me would be that you put the commit that changes the
signature by itself in a branch based on 4.19-rc3 (or earlier), and then
we could both just merge that.

But not sure if that will work with whatever else you're trying to sync
up with.

cheers
