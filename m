Return-Path: <linuxppc-dev+bounces-25881-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B83C5CFDB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Aug 2026 00:47:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hML5y0xYCz2xy6;
	Sat, 15 Aug 2026 10:47:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786754838;
	cv=none; b=LbgbIaVz2u5DtWGPoeqz628Y50wqfCsVnU6LbilLNH+vT+lswZmwbgGVVnd1AN9K1CrHR3WRK0koyQ/KBN2nnC/R5qRL8nEtrTEBDZbvC48E0qK09gGN04zm+bViluKWBGnCaGJZBFElecoa5y9wzkPqI6CyemNZAz6E3jq0DqDnQBoneYmOWx04qWwbylwZ5Xicp8zTCAB6Q3D7eojJy7rPwQXike8Ko845OjLnFQT6+RbZLocVJQFdpl2vtRTq3h1ibWxf4LiMy88nFUgttv1AwGkejgZ2txjdAGlV/hSKiR5+alhP5z0QApXUnBNzyjmlBX91wk1qzBdEmhlltg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786754838; c=relaxed/relaxed;
	bh=jGt4LrlCFr4+ICwTb2T9nscKa29NLIsS5EoduDa2V30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIW3N6FaxQA9K9YETYHSHiibpfXWR/0P9hcBMMbxhWP147Fm5HpFlz7Idoi5b9INdzMpffW6RRfEVeIMz49peHNnFqZBLPOjy7dmdkhZbVu/3tEpegaUsLU61Frcj762rSxzJn3wy0qS5h84oHd2Khc2F/U0+ObRd/K7fmJJ4PGf/vRLu7zOOB62LxSEMuef9Qi2HTqLbzl5qCaEp9OwhwlKPIKmIOQnqYfAspeguQPQ2skTc0t3AhHkPARPUsWcEwmmFxmroSIQVUxV4JMKpLrn2A/UxxQSF23nb8YoU0mEHd4IxD8GZzu3SlR19IpgbvcKqu0GYSLjIOJP3okWEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CbdwpQFk; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CbdwpQFk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hML5t2MTQz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 10:47:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786754835; x=1818290835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NObMa3pZfRNWZi7qClKgPXqIqjV99yfig0YmhAPyyY8=;
  b=CbdwpQFkPXf9TuF5BZtRonGWzJ5rgqgS+BptDgdBQ0ou7Ub20Eb/H0hS
   7+Q/hjZm28F4kf3GZX8j80HqVWMDiTx95C2AkPi2P0GMVaI3puqNdlDus
   0b682vqhUuJGrskyXtASgoP4NBwgaoUrLH/ivabe5AXyQUqyt8iOT5nzi
   un+FOfDpD/3t4Ms/mFpAgcELvStEhRcvOQOu6YXth6hoR9GddJAmgZLZc
   khew7RyHG4c52HpyW5ez2APx23EuE8SzdwnOKL8j8Vn+1LqA4Z4r7sM9m
   ayiqC4z8Nb7LptTDah7ASfSAs8MTFIUzBbOq+nSOb+5ld7dpTG/4XM66E
   w==;
X-CSE-ConnectionGUID: Ur/gksp/Q9mAjHjuBnGo4g==
X-CSE-MsgGUID: zcXVqrRpQHiNp2k2cLxUQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="98487995"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="98487995"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 17:47:06 -0700
X-CSE-ConnectionGUID: 8db7sIexQ1KwqJAkCbD22A==
X-CSE-MsgGUID: jO6fncqJTxmuWNzokzeYnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="263030085"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 14 Aug 2026 17:47:04 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wv2YA-00000000afm-1Qcd;
	Sat, 15 Aug 2026 00:47:02 +0000
Date: Sat, 15 Aug 2026 08:46:37 +0800
From: kernel test robot <lkp@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Vaibhav Jain <vaibhav@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] KVM: PPC: Book3S HV nestedv2: Don't drop pending
 doorbell across L2 entry
Message-ID: <202608150815.zhSReMmH-lkp@intel.com>
References: <20260803034426.44249-1-vaibhav@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803034426.44249-1-vaibhav@linux.ibm.com>

Hi Vaibhav,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/topic/ppc-kvm]
[also build test ERROR on kvm/queue kvm/next mst-vhost/linux-next linus/master v7.2-rc7 next-20260813]
[cannot apply to kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vaibhav-Jain/KVM-PPC-Book3S-HV-nestedv2-Don-t-drop-pending-doorbell-across-L2-entry/20260815-070415
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git topic/ppc-kvm
patch link:    https://lore.kernel.org/r/20260803034426.44249-1-vaibhav%40linux.ibm.com
patch subject: [PATCH] KVM: PPC: Book3S HV nestedv2: Don't drop pending doorbell across L2 entry
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260815/202608150815.zhSReMmH-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260815/202608150815.zhSReMmH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608150815.zhSReMmH-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/kvm/book3s_hv.c: In function 'kvmhv_vcpu_entry_nestedv2':
>> arch/powerpc/kvm/book3s_hv.c:4304:25: error: 'cpu' undeclared (first use in this function)
    4304 |                         cpu->arch.doorbell_request = 0;
         |                         ^~~
   arch/powerpc/kvm/book3s_hv.c:4304:25: note: each undeclared identifier is reported only once for each function it appears in


vim +/cpu +4304 arch/powerpc/kvm/book3s_hv.c

  4248	
  4249	static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
  4250					     unsigned long lpcr, u64 *tb)
  4251	{
  4252		struct kvmhv_nestedv2_io *io;
  4253		unsigned long msr, i;
  4254		int trap;
  4255		long rc;
  4256	
  4257		io = &vcpu->arch.nestedv2_io;
  4258	
  4259		msr = mfmsr();
  4260		kvmppc_msr_hard_disable_set_facilities(vcpu, msr);
  4261		if (lazy_irq_pending())
  4262			return 0;
  4263	
  4264		if (vcpu->arch.doorbell_request)
  4265			kvmppc_set_dpdes(vcpu, 1);
  4266	
  4267		rc = kvmhv_nestedv2_flush_vcpu(vcpu, time_limit);
  4268		if (rc < 0)
  4269			return -EINVAL;
  4270	
  4271		kvmppc_gse_put_u64(io->vcpu_run_input, KVMPPC_GSID_LPCR, lpcr);
  4272	
  4273		accumulate_time(vcpu, &vcpu->arch.in_guest);
  4274		rc = plpar_guest_run_vcpu(0, vcpu->kvm->arch.lpid, vcpu->vcpu_id,
  4275					  &trap, &i);
  4276	
  4277		if (rc != H_SUCCESS) {
  4278			pr_err("KVM Guest Run VCPU hcall failed\n");
  4279			if (rc == H_INVALID_ELEMENT_ID)
  4280				pr_err("KVM: Guest Run VCPU invalid element id at %ld\n", i);
  4281			else if (rc == H_INVALID_ELEMENT_SIZE)
  4282				pr_err("KVM: Guest Run VCPU invalid element size at %ld\n", i);
  4283			else if (rc == H_INVALID_ELEMENT_VALUE)
  4284				pr_err("KVM: Guest Run VCPU invalid element value at %ld\n", i);
  4285			return -EINVAL;
  4286		}
  4287		accumulate_time(vcpu, &vcpu->arch.guest_exit);
  4288	
  4289		*tb = mftb();
  4290		kvmppc_gsm_reset(io->vcpu_message);
  4291		kvmppc_gsm_reset(io->vcore_message);
  4292		kvmppc_gsbm_zero(&io->valids);
  4293	
  4294		rc = kvmhv_nestedv2_parse_output(vcpu);
  4295		if (rc < 0)
  4296			return -EINVAL;
  4297	
  4298		/* Check if privileged door bell was requested and handled */
  4299		if (vcpu->arch.vcore->dpdes) {
  4300			kvmhv_nestedv2_cached_reload(vcpu, KVMPPC_GSID_DPDES);
  4301			if (vcpu->arch.vcore->dpdes)
  4302				vcpu->arch.doorbell_request |= vcpu->arch.vcore->dpdes;
  4303			else
> 4304				cpu->arch.doorbell_request = 0;
  4305		} else {
  4306			vcpu->arch.doorbell_request = 0;
  4307		}
  4308	
  4309		timer_rearm_host_dec(*tb);
  4310	
  4311		/* Record context switch and guest_run_time data */
  4312		if (kvmhv_get_l2_counters_status())
  4313			do_trace_nested_cs_time(vcpu);
  4314	
  4315		return trap;
  4316	}
  4317	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

