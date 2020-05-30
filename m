Return-Path: <SRS0=qrpl=7M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544E2C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 May 2020 16:37:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A37C20707
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 May 2020 16:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ztIv525F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A37C20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Z6Xj2Y9bzDqlf
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2020 02:37:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2a00:1450:4864:20::544;
 helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=ztIv525F; dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Z6W00GZPzDqdX
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2020 02:35:34 +1000 (AEST)
Received: by mail-ed1-x544.google.com with SMTP id o26so1181839edq.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2020 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zDPgsDC+Fjw05Uy8ht8rySTjxa/FIb4k6efkMWlug6I=;
 b=ztIv525FWUuRebjARCuK7nVYHZe/dJCKraz620tINksAHNR5k6Z5lnzEUn5rJZllrS
 S7DOl6p7C8eufks3T9AEtPO3wq5N8Bp/Z+xssUrtpYf3IhPdQJZSlEz2CgioQHLtMEfj
 iBTbLnYgbiNr7JDLWkmIRrKWPh2tjGj6U8H4Di0O9zkxp117GVhjqcKHJLD9Go3FQTmq
 9v3ltiQEreNDEqsV9wMWbmW9+MMxrYb8dD39iYHFJCDlFAJpIarZETfxMU04LgUMUkg3
 FbxjN6DXBvH8CrZtAI2gtczDq2o0dC2CKc+xG1jjMK4iunxdoA2lVMUR3WXN1tlg1M2x
 aILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zDPgsDC+Fjw05Uy8ht8rySTjxa/FIb4k6efkMWlug6I=;
 b=KCuxHo/BbZfg+A6qeuxSP49aFUMEfoJvuIVtRwFke7iMr5AanlntyuqXfYhR8cLnIo
 9mFIFjbJqJaHRcyxgh30MdRW3BBCEMR79ftAnRnoO/va7fxuixL8m95/DUHXd3CMRquy
 z7YGV+oQjMpFa91x+FFEEyh70YAknYdKxqKHI06XYFXipVy4JcPgYkR6k4IkYXzbG0e1
 bD/E/m/WLebEz1kWxALOJThn6wmpP3RA2yncEaNCukBiNn9XvSRUjMvta8goBwITjgT+
 68/i2xt93yvgc4SWC4UVqLQvhHbcrqvHEW8lJrZ9BgtP9B5ARiMdaCNmOPmmkYD65/+6
 QtTg==
X-Gm-Message-State: AOAM531iU2Z5Tb9NuAOyi9QznL5zQlos+uM2XbVQTZC1c8ntPj+zln0w
 C5DIQgve0rZaLPxCHV5hH5xcWwZ6u3zCp857ZGMbiA==
X-Google-Smtp-Source: ABdhPJzrmF5UxpGeRUgFsqeE7fugpOQNoQE1OdjFRbD2EHpNe1SLiNydKeQ/GpONBeVkNwHIotJ0M9+h2cKe+Pj0T6s=
X-Received: by 2002:a50:f40d:: with SMTP id r13mr13102099edm.93.1590856529133; 
 Sat, 30 May 2020 09:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200529054141.156384-1-aneesh.kumar@linux.ibm.com>
 <20200529093310.GL25173@kitsune.suse.cz>
 <6183cf4a-d134-99e5-936e-ef35f530c2ec@linux.ibm.com>
 <20200529095250.GP14550@quack2.suse.cz>
 <7e8ee9e3-4d4d-e4b9-913b-1c2448adc62a@linux.ibm.com>
 <CAPcyv4jrss3dFcCOar3JTFnuN0_pgFNtBPiJzUdKxtiax6pPgQ@mail.gmail.com>
 <7f163562-e7e3-7668-7415-c40e57c32582@linux.ibm.com>
In-Reply-To: <7f163562-e7e3-7668-7415-c40e57c32582@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 30 May 2020 09:35:19 -0700
Message-ID: <CAPcyv4i7k7t8is_6FKAWbWsGHVO0kvj-OqqqJTzw=VS7xtZVvQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] libnvdimm: Add prctl control for disabling
 synchronous fault support.
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 jack@suse.de, Jeff Moyer <jmoyer@redhat.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, May 30, 2020 at 12:18 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 5/30/20 12:52 AM, Dan Williams wrote:
> > On Fri, May 29, 2020 at 3:55 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> On 5/29/20 3:22 PM, Jan Kara wrote:
> >>> Hi!
> >>>
> >>> On Fri 29-05-20 15:07:31, Aneesh Kumar K.V wrote:
> >>>> Thanks Michal. I also missed Jeff in this email thread.
> >>>
> >>> And I think you'll also need some of the sched maintainers for the pr=
ctl
> >>> bits...
> >>>
> >>>> On 5/29/20 3:03 PM, Michal Such=C3=A1nek wrote:
> >>>>> Adding Jan
> >>>>>
> >>>>> On Fri, May 29, 2020 at 11:11:39AM +0530, Aneesh Kumar K.V wrote:
> >>>>>> With POWER10, architecture is adding new pmem flush and sync instr=
uctions.
> >>>>>> The kernel should prevent the usage of MAP_SYNC if applications ar=
e not using
> >>>>>> the new instructions on newer hardware.
> >>>>>>
> >>>>>> This patch adds a prctl option MAP_SYNC_ENABLE that can be used to=
 enable
> >>>>>> the usage of MAP_SYNC. The kernel config option is added to allow =
the user
> >>>>>> to control whether MAP_SYNC should be enabled by default or not.
> >>>>>>
> >>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >>> ...
> >>>>>> diff --git a/kernel/fork.c b/kernel/fork.c
> >>>>>> index 8c700f881d92..d5a9a363e81e 100644
> >>>>>> --- a/kernel/fork.c
> >>>>>> +++ b/kernel/fork.c
> >>>>>> @@ -963,6 +963,12 @@ __cacheline_aligned_in_smp DEFINE_SPINLOCK(mm=
list_lock);
> >>>>>>     static unsigned long default_dump_filter =3D MMF_DUMP_FILTER_D=
EFAULT;
> >>>>>> +#ifdef CONFIG_ARCH_MAP_SYNC_DISABLE
> >>>>>> +unsigned long default_map_sync_mask =3D MMF_DISABLE_MAP_SYNC_MASK=
;
> >>>>>> +#else
> >>>>>> +unsigned long default_map_sync_mask =3D 0;
> >>>>>> +#endif
> >>>>>> +
> >>>
> >>> I'm not sure CONFIG is really the right approach here. For a distro t=
hat would
> >>> basically mean to disable MAP_SYNC for all PPC kernels unless applica=
tion
> >>> explicitly uses the right prctl. Shouldn't we rather initialize
> >>> default_map_sync_mask on boot based on whether the CPU we run on requ=
ires
> >>> new flush instructions or not? Otherwise the patch looks sensible.
> >>>
> >>
> >> yes that is correct. We ideally want to deny MAP_SYNC only w.r.t
> >> POWER10. But on a virtualized platform there is no easy way to detect
> >> that. We could ideally hook this into the nvdimm driver where we look =
at
> >> the new compat string ibm,persistent-memory-v2 and then disable MAP_SY=
NC
> >> if we find a device with the specific value.
> >>
> >> BTW with the recent changes I posted for the nvdimm driver, older kern=
el
> >> won't initialize persistent memory device on newer hardware. Newer
> >> hardware will present the device to OS with a different device tree
> >> compat string.
> >>
> >> My expectation  w.r.t this patch was, Distro would want to  mark
> >> CONFIG_ARCH_MAP_SYNC_DISABLE=3Dn based on the different application
> >> certification.  Otherwise application will have to end up calling the
> >> prctl(MMF_DISABLE_MAP_SYNC, 0) any way. If that is the case, should th=
is
> >> be dependent on P10?
> >>
> >> With that I am wondering should we even have this patch? Can we expect
> >> userspace get updated to use new instruction?.
> >>
> >> With ppc64 we never had a real persistent memory device available for
> >> end user to try. The available persistent memory stack was using vPMEM
> >> which was presented as a volatile memory region for which there is no
> >> need to use any of the flush instructions. We could safely assume that
> >> as we get applications certified/verified for working with pmem device
> >> on ppc64, they would all be using the new instructions?
> >
> > I think prctl is the wrong interface for this. I was thinking a sysfs
> > interface along the same lines as /sys/block/pmemX/dax/write_cache.
> > That attribute is toggling DAXDEV_WRITE_CACHE for the determination of
> > whether the platform or the kernel needs to handle cache flushing
> > relative to power loss. A similar attribute can be established for
> > DAXDEV_SYNC, it would simply default to off based on a configuration
> > time policy, but be dynamically changeable at runtime via sysfs.
> >
> > These flags are device properties that affect the kernel and
> > userspace's handling of persistence.
> >
>
> That will not handle the scenario with multiple applications using the
> same fsdax mount point where one is updated to use the new instruction
> and the other is not.

Right, it needs to be a global setting / flag day to switch from one
regime to another. Per-process control is a recipe for disaster.
