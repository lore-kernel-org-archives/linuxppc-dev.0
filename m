Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6786606A31D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cpLQzYTb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jB71S6hMsz2yFQ;
	Sat, 24 Oct 2026 02:56:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792771004;
	cv=fail; b=KtCStaVgdFUN0UTvufVyAGn770XBWf9Cz5FaKpDRdLRqU1gBUWL6Xdeh6jWskqzwaejwSHjgMb5kamoCYW259Wss+me142sgoKMrAXhkimy4Fp9y2heR6l1Mr7/7h9sVLeP2L15OdogRKKv81PMIaB2hsv2o5d1lStVLP+ChI2kpCdqDddbWs0NzJezBIpzBl+1LYbq0JAf0twSYnVkVB085NLLNp901OhhT3F4bVDVcPcXBJQ40lvlbBX3e2ilkbaDNrqQZdj+zJ9npJOiDHQ1O3ZPOoRnJjHVAVpo81BfOGTwapzsMItTBR4FRlH1OX292nwlh2XAzJ4NP5Z842w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792771004; c=relaxed/relaxed;
	bh=Io4JDRmv/7LAqfN2ndyYDaeCe7lZAtDjXoHXyixXjCA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lDZSYDNN3ejEkFwQYLIlMw5evWjkyBvZk0azPxyRMgX++YlF3VjYL6Dw2U8HE7Vmyq70paR0t5+Lo2Sczocksl73mlYLM/WgVvkIIrgbbHg0Td7etahdr+4SNNH0ONhiP0oeJvQrBge/NDtVkxQjOLWmI7x+ptr9q5ysPLGzliScGoGBSSwAknYDbPyASTAZ6jSGKkfkHTFxl/f0obj4S8aWpDKtaQWxuoP6B68lvp2lkU3mpHty9MXjcGQymXsi1O2P9DGYV1Zi42gMMHFqCBSqU5VQLoGXeh2+rvyYj0IFLRBiDQHwSf+R6lkFiR5NZtT8pmnA/jZDq+P+rf7rxQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cpLQzYTb; dkim-atps=neutral; spf=pass (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cpLQzYTb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Sat, 24 Oct 2026 02:56:42 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jB71Q0Lncz2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 02:56:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792771002; x=1824307002;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Jj9Zfha1o7UziFCyOhXw9gpJmygPmhKS/GAjs3eA6Nw=;
  b=cpLQzYTbRRMUfz9uJbWzNLo9WtHCv8H8T1+pEvvGfgJLpGFh3OnmFZZa
   S7P8c4stg1/fF0ODU9Vkd7AJAYpV/fIDUtgGMg+rC0ehFnfyZ1Ay/cC0I
   72VLPZeGgbl1re0m4wIeh4N7QU1dHvS12DzyCgegX1vVf6pMHJ1IWTD6o
   Rjs/aBfaHsLoxPMNVDn8m7cuc+1ay9KCa7LJ0ujfGBqhgYMGfQV7nX/rC
   GjbfFAaMav9nqCF0c6nLNNd490CQNWEc3hbDgKbd9W2IA89B5m3PRGkGP
   +u2HRYENyjMgGejzezMI42B8UHiU6J5GjNDlzH/SNMiukMHqXxPWV8gWp
   g==;
X-CSE-ConnectionGUID: 0BU45NJsRsefN3/dpIp/kQ==
X-CSE-MsgGUID: /JQiC/N+SVS49IV7v+qscw==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1420395"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1420395"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 08:55:31 -0700
X-CSE-ConnectionGUID: YDBE95lJROqKVcHKznGNpw==
X-CSE-MsgGUID: cVbGn3lARoCrPNaAsJe5Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3556987"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 08:55:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 08:55:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 08:55:29 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 08:55:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhcoID/M31grPjXXUpHOWQK5PkeCxtigZpLpUhTLxaP6HaDH0JOGI1mUhkmiWJzclZRI2wE+LHXAPHIXkYL87KXQow0dGq/u6HHka7ygaeRtPA2rAVhaKOGPVQbHYrtS9NsMVz5oATmN4nHldBWo1EJjlYS56qnOQGS+VI5u5E3VtvbwpVpZ6bhKe3EX/f3m56do49KTh4S3uOBA/VlaIVW64vgTnNSAzLvDFZ8uLLScpvrJdbTotakJk0UqloKJfQibDoaLM/YyG4OVcNNfByr12uYWn1+DM/CMJXWdGgPQ2n0CqiKW+jQoK3BNMSVrp14Ip/MfeIiEiHE95553Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Io4JDRmv/7LAqfN2ndyYDaeCe7lZAtDjXoHXyixXjCA=;
 b=QPImRHye09wDoR+tOdx5k+q9iMQBdWpDPRMXd2Ls08hJNPsY9iti0/plGnUAnajny8jJ39FEcYFsHOqIuBd4Xg04nsOlgKOUE0+N44MOdjPrum8SCr18mhfk4mTC2YF2AEPcsS7uRjXUxsKXpcoCuOih/1ML/YIxmojhv/YMrjH0fBuGteNtyyyk73bNHEEmT1QJOYmj+5BnGUCWnM7f6XvOXjmAfA1AwcVCptqysmGt6UwI3VKhYFrF5xsuSy8nHH+bEXNVFPffWIk2AGsIymD/rnPe9hETyu/aplUO4A8QOmI4+DpqTQ6m4jlInYYzZGzApXw7lWthRtaD3qFFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH0PR11MB5206.namprd11.prod.outlook.com (2603:10b6:510:3f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.17; Fri, 23 Oct 2026 15:55:26 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%3]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 15:55:26 +0000
Date: Fri, 23 Oct 2026 23:42:32 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
CC: <maddy@linux.ibm.com>, <linuxppc-dev@lists.ozlabs.org>,
	<peterz@infradead.org>, <tim.c.chen@linux.intel.com>,
	<christophe.leroy@csgroup.eu>, <linux-kernel@vger.kernel.org>,
	<ritesh.list@gmail.com>, <kprateek.nayak@amd.com>, <vineethr@linux.ibm.com>,
	<vincent.guittot@linaro.org>, <srikar@linux.ibm.com>, <npiggin@gmail.com>,
	<mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/4] powerpc/topology: Introduce llc_override kernel
 parameter
Message-ID: <atuAaE4Y-_2CLA37@chenyu-dev>
References: <20261023131646.2907938-1-sshegde@linux.ibm.com>
 <20261023131646.2907938-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261023131646.2907938-2-sshegde@linux.ibm.com>
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH0PR11MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: cca7823e-a78f-4a51-3ec3-08df311e0df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|261009223027099003|261021121427099003|56012099006|10067099003|3023799007|22082099003|18002099003|4143699003|11063799006|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: zKplD5dS33M0i6GcOzV36/o4V+TIB+9Gejlwtr7K6blqO7l1pArJkuy7zHc6T7/ypQe6kt5UnpiHBn3Z9mZu7ZpDJY4N9X/bxmKNh4H8KIR0WAOoy/NY4sgBf27ciQSumW2rfVHoiWl4yuWZGzfz5lGsIidsl57tZw/o/90jsOq+Mvd8WdsaSBgXSkJMzJ2L9iht0VCskd/eaPbouGb6ph/3MSKjyG+lHZmPD569IgznXgfH3+HcOUIaqU68uLOw4JYQoG5effPKfqZHZe/pf+vdSjnUPvgwVjDU43Y/pzUL6veY3grhMwRtO73qNNfw0BuWvT7KfePVyqdS+7tScrWGHTnfNlTSnubDO+moayMCHN+5Ffj3cc/qqj8LRq6dX+6R8XmYew+6BybPDnjr4OIxC6k+U1mR5PFRd475c27z9kEMG4sAt//RwjhzTav5xpUnIaoFEK9dJ4vnbY0d3Gn3GKTRmnTfbV12J0+EOIgnmKdF3B1cFV73N87Lbo0zoWLpXUycTPSydGgKZY8cjNK5hbIk5UL9ipTjTY6WdtgXZZCLec7kMsCZqJ7YynfO6a4gPLwPt3HwixoX4FPPs9hpNRz3VpMh1vBvaGDDpsLUdJY0bNGunTTLJESj5Y0JUfUOiS7hYeSX/jtI3ii/Ey+FWIgGOWJKrTACBl+cNFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(261009223027099003)(261021121427099003)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iiVVupJmShl6eUdrc5rMO3/lef6VKHOg/VxZq/LBKW822QV+n965KluwlUOQ?=
 =?us-ascii?Q?mk3lC/DN721SsTE/g9wGRykHT8W99Xnwy+CZpokjx1PvmL0HkGA/h2ryL1G6?=
 =?us-ascii?Q?K6qAlH9qIihbMaE48PD/YhFcgd4JZIPsM43aUNbLUN0q2N3KMzx4EsAF7imv?=
 =?us-ascii?Q?cRGpgCMVRGibC+GfoMofZdWviY/8Ajy6xASxZmqrAoQHQjBXo2NOGy7UDWlA?=
 =?us-ascii?Q?+GO3FIM3a0MR0IiXBDqtj6dexHfCx9gLFrQS7oOJoONgCbG/f3XCoq54uQip?=
 =?us-ascii?Q?9G3MdPHGvdWhmfm61Cme4VKMTTc7eRGZBU4wfQpZ89o1u19ucpk/TwzueFfR?=
 =?us-ascii?Q?+t85cbF6puLSaMw4r10EiHyirrw/TEpxhWzsovtImHeCuVtmf4pQ+68FEtZM?=
 =?us-ascii?Q?u9zmmSXhL7Ywx/2NNylFJCdRKCaMyO+K0Kg+QzRKzZ5ZfLZQfGUhsKscmN93?=
 =?us-ascii?Q?DtP2RL/Sdr3XUravZz7krRx5Roquu6sZvpxuyZp+62eds3cPqlFQzDn10Fdq?=
 =?us-ascii?Q?LuBQnrZFErgQQJtJMj6hf9RwlDsVkmvQljVgoiyJxi0VAPQNXq/GbvHRdQ+x?=
 =?us-ascii?Q?aB7vhVmAcwOpskjCAQXmc9rdCMdTX8SAlSHjA5cSSn5aLBw3IyUuF0swDlQk?=
 =?us-ascii?Q?xzKQIon35RQYBbIdXfBbWyiR2eBBpNL7QYF7IcZyqjMPWZ9F/8EDw6y+d370?=
 =?us-ascii?Q?3DUg3kdCdAs8qkopdIAloFQpnJ7jClIZf3/W4+HTxV3famCqRy+ECq3TsqUF?=
 =?us-ascii?Q?jzxwqhJtRr5jiUeLQIMKOq0+P0m9haL/ZsMq2uuS2+xKbKzAHB2PyQ6OYWhe?=
 =?us-ascii?Q?U52oi0kSIxLWQw3+r5Ic75jnk77maakDTRY2uTAkl/11AHZc5XLCKAn4PLF7?=
 =?us-ascii?Q?M6wBaawX4XN6qpvqUe7TJvA9rHeowAbXgBHantWjYDwAzkBMUOEiyxUQJJx6?=
 =?us-ascii?Q?qMwjYeocIcB0nO2YlG7jMJsw8R6SS0mr3zjS7goyofKDnTsIbYE75PauZWFe?=
 =?us-ascii?Q?a+Y5vgc2GpUJXDaMV50/Mlm5TLKbmcbJJWih9tWnNN89IzDNUGjN1+PjrZak?=
 =?us-ascii?Q?k/Cy2MiAEpWqBpKOVHCt8bC7ajXtEhWAMFHl3t6oSlV8Af9Jqbui6GIY60Gj?=
 =?us-ascii?Q?wMMWM9F4UTJv5UZyssCmIGGmcRH+gij6Jvq1frQkfraJnksHPQk6+gFiKSaG?=
 =?us-ascii?Q?PH7OgdG/2wS6TmbzxlqHKb6rO7qZLnzr31owStr4JLOIIBaLhB+N9PSykbZa?=
 =?us-ascii?Q?hI6gxUbNccuudWLGAw4U0KT7V7eKP3b5FYrx3VAhO+v/r8T0205cW90MJDpr?=
 =?us-ascii?Q?uGFmfJNzJUnQZEO90S859qRR4uqzevJiAGhCUopfLZ5LLMlqELWQlGxjJXDD?=
 =?us-ascii?Q?ZajT4QXP+O2pvO9limtBx3fU8X3tPxfaI3NUNXT02Ht3nq+U+seawKHdy17C?=
 =?us-ascii?Q?KvAIJ3YdXTBZuMsBN0tt6NNaxH1/rxTpGkMlLHCbYbupqmgwFTTq5Gk5rxWu?=
 =?us-ascii?Q?bzsOtduzQfCnnyD6UG30J4e4Cs/Tk75QVK0lecK7qxmMohUXS+dK6OC8vDPJ?=
 =?us-ascii?Q?agW3/hVQJ/CKWfrdLTAqvRQzHXs6vNy6//BEcYCrMbpFpKu3sceJd6Z12go/?=
 =?us-ascii?Q?Zomw0DKAyoyzd1ynoMMLc3b+67+BgcQLWErV3sGKk4wLWN4kKbNms5md5GqV?=
 =?us-ascii?Q?g5Iibt73BRuzZ30oBt9XIxsNvQyT+cdRF6huxh4TNysG4vhlM+ah/JGhigXl?=
 =?us-ascii?Q?tBTgIF34rQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 4lZ6IeSO+j0o3RCdrO8bS9TgznsH2iKsqJU54yApd7a0wKuOqfvtb1kKplIE/HTqKgqdqfyFm7jsZZryf36cG9xzpFRm8zrMOVajHGJRegg7/tOoe4mn8PMoPqKLa7GgJRRS2QdhlXPoKCqu7eALAUAKS9t3tjSaRJLBSJyKg5Ly2Xlq5voGE9y3DZYYVpOlarWK7UHp+bEioWXM83NDR9dfFGmmJoJGIt3uuK2nhjkbI2es/GkebSp0EJpvoAwPJgzw74wXMFxsZWOgN134a/orTX0aqKTp7uv6g1Yt2gGaLQ3o96JniXaMDpYHRLSTkOrtKvCeEwjzYa2LexQliQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: cca7823e-a78f-4a51-3ec3-08df311e0df1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:55:26.5967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bI9Eqkki/XmBpGHVmyRtJKwSMMtIgB+9Mr19nZd5XNH03lItphPShh0D6zJdHh5IO4HUTVAAjMJ/v672UMiohw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5206
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Shrikanth,

On Fri, Oct 23, 2026 at 06:46:43PM +0530, Shrikanth Hegde wrote:

[ ... ]

> ---
>  arch/powerpc/kernel/smp.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 6a5a5469aaae..6b1201ea3572 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1059,6 +1059,29 @@ static bool has_coregroup_support(void)
>  	return coregroup_enabled;
>  }
>  
> +enum llc_override_values {
> +	LLC_OVERRIDE_MC		= 1,
> +	LLC_OVERRIDE_PKG	= 2,
> +};
> +
> +static int llc_override;
> +
> +static int __init set_llc_override(char *str)
> +{
> +	if (!strcasecmp(str, "mc") && has_coregroup_support())
> +		WRITE_ONCE(llc_override, LLC_OVERRIDE_MC);

There is only 1 booting CPU at the moment, maybe WRITE_ONCE() is not needed.

> +	else if (!strcasecmp(str, "pkg"))
> +		WRITE_ONCE(llc_override, LLC_OVERRIDE_PKG);
> +	else {
> +		pr_warn("Unsupported llc_override=%s\n", str);
> +		return 1;
> +	}
> +
> +	pr_info("llc_override set at domain: %s\n", str);
> +	return 1;
> +}
> +__setup("llc_override=", set_llc_override);
> +
>  static int __init init_big_cores(void)
>  {
>  	int cpu;

On PowerPC, it seems that get_effective_llc_bytes() always returns 0,
which makes exceed_llc_capacity() return true, so cache-aware scheduling
is disabled on PowerPC. We might need to provide an arch_llc_bytes() that
is adjusted based on llc_override - sometimes calculate the sum of L2 across
several cores.

thanks,
Chenyu

