Return-Path: <linuxppc-dev+bounces-19455-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40852EDB7D0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 00:13:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr3Rn4p2wz2ynH;
	Wed, 08 Apr 2026 10:12:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775607173;
	cv=fail; b=YunKM3eTRSwV0onUdIcRM3GGHP/3Vp9L3Cf1mcr05nHyyX561MJ8VsgZYhM9IR2XTWavnEFiKbogXiqnuBWPjzm8u4ZDRaINvGqnjkaT1UjaGQCbylU1p5EMsVCGWTVXGaCegMd/G3MgPUkARg1niqEg30vaawuegBga37PrUzapflEOZAz/BotRmqbPF9WC6QRr2U1EXlTX6LeGtUfjYLTnpOVY+NawHqOWxzGTttgE+aKpnIls+Tn93j+OAu0ez3AzruezbX0sc92TCvzjxn00tCoTkt+bn0df+6BQ9Qe+lMTr1HGpvvHtP8/YIu56tSu2gGkx5DSi/ORfgr4a7A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775607173; c=relaxed/relaxed;
	bh=PyMlckwGvP3HnQaH+7OKKjm4GBje42aG21PW2eDFub8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AywAOzrt0tMoPvI21Tu3ibDZqQhX55JvvBZpD0HFf2axxm9cxTwSsnOwMvR4qRpbTkDkiPZdKXuyEBMYy/aB1RT9tRpUP3VHhts7TL/HrZlMJ5G9snNARzjfv61sMtFwGjmFvh7ILh39rB7RDx7iNXtXrmtri60TYvtu+16dK0Zy/w4a3rpl7iOe7U3lW6WdF9dIE5i0TUMwQBJ1/VjZ1NpSs8lBVO1TrOu+hIckGue5BpRgEZjbHVoUbfVZbkHEkyvPMKju1sZc3Cil7teQmG1PrwUP9Ok2w6RltnefpVcYY4IRDSRrsjpQRL+MtQzIZgfUn4p1WHysk2Zs1X0suA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lDaI+g92; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lDaI+g92;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr3Rm0bPrz2yr6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 10:12:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775607173; x=1807143173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=HJbPDeF+WPeL5foRctvZ1+POr5lFQSblmKA6N/v1bp0=;
  b=lDaI+g92C1vFmjdwXRqip2PQUzwO4dRbbEg/hyAu7Px6h357cYl0/nYZ
   ZbUbcuHcdpkQ4icpEVWY3fyAf2aEL0vTryQthYJkgtZq41WlZSyzxRQ8d
   YsEMitFwOeOJ6H3ylEWg1dwTR5iesxDqgAUL3iyMG9nKEJubWERXROosO
   keSqkKGf8ydjGImp5vRrNqE1ovxFZR6J9HQh87GBZp8GWkdmxJvQbFP1H
   nTd51JPgG2yEaoMEN84StLphVa3P7CJDHCCP1BHWIRCFCCWvPYib7Otcz
   oAFYcbSxO8GLC/rCpfinX8IgxWGA8p5zKG9hdzw4N5XlS8GC6zsqgE2RB
   w==;
X-CSE-ConnectionGUID: eys+5kx3Rr2UkGf12f8H2A==
X-CSE-MsgGUID: uIqp0VMUR1iBo+KGGd/Clw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76462876"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="76462876"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 17:12:41 -0700
X-CSE-ConnectionGUID: ePAZYGG2QA+rXKXCEVeM2w==
X-CSE-MsgGUID: gmBcmd/aStWv75XB4K8vqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="229981380"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 17:12:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 17:12:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 17:12:39 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.21) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 17:12:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCEg+N2/0rdIyyZ8gZaJdE+BBMpv1zK5GAfK6qCc9AanayvfpvJzsrWfv8K07psZnypQnZofDP5i4x8KyircFvTaM8k8w20WN4gjgrI7dKpve7gjUa8HykDaxpGwNMhyLxmZ5RV18l0jeFj4/Wf0Ns5ZjPrfxm51bmR20dC+oKPsTh49nq8Nx8NBVorzuVj9kGfkG7dl/FZ4smZG13EACbNIqVmmT39RKaLeMY0a+UGbYSADIMQmOq5mM+OJPSDI7OrCJc/4vRkhHS9V+rWxFeYIyRE++bnbxCPyZJKQiCsn6c6tSXhkbnr8NULDt8EbTjl71sLOWuBw2LCspgN6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyMlckwGvP3HnQaH+7OKKjm4GBje42aG21PW2eDFub8=;
 b=ErDZu4TrPoxj0ZWSSd+R4GjZKl6Am7CM+cD8nXdZaz7x4soc06ulH1/3pzLvWAZopbtiFsRBeV55mZuMKe8Zi0FL3KdN9pdSYy0leSa0AdI9HUHyeIbBjLUSfIwhSHi0NW5pW7aNDgqcR/B2J31XfDjXZlzCElzifsFriAsNGknRSTYfWKmtEZ8kgLT5vWioJANpfaIxxBOq1EWfICedCoVkDoskzo5yFcoQVm9Z/+ygFpxJnSi7Acl4HUpLKg5299XUB7KObzOjWeLPP2au2lviK9o/oqSEZkW4k89/xzDs2Yoe6iflLer/3dj+WRnk6Tdq7aucfC/i1t/q1IOOUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 8 Apr
 2026 00:12:36 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 00:12:36 +0000
From: Peter Fang <peter.fang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Nicholas
 Piggin" <npiggin@gmail.com>
CC: Yosry Ahmed <yosry@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <kvm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Peter Fang <peter.fang@intel.com>
Subject: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
Date: Tue, 7 Apr 2026 17:11:30 -0700
Message-ID: <20260408001137.3290444-4-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408001137.3290444-1-peter.fang@intel.com>
References: <20260408001137.3290444-1-peter.fang@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:40::24) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|BL3PR11MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: b23f9b63-40f0-45ff-47e1-08de950389b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: n89boivCTCvnhkGZUYL9AbsXvhwrV1ON7De21qfEE3XsRCYe3v3U3xIveDksRWLWhqUXe14/ADkeZN68+iIsqyDuX71oyZxP34gs2yeREK1A5JlBxr+BeIjbWIWBW1GtssbpC503KHUxv2uRNQa0io7p5/7sWVc16TWb+TLGvzDBh1PQ1NJQlgyNMD1WZpMyGKuw3Z5rV10f1kfT2kRh6id5hKt15l2sPRSKs81JJa07BGlIxsY0Ha4gSmwBfspD3/gS4k/bSbtBcx07byDjKsci3T+UWJlqcTXvLCftMCBo2IA7Jtl+hwJA6yQ7UKU3c+2d3cZggibvwG5o2E2HE9XSDEZZWY4zW2pOIcmLhiL+UvrvhrlqhEQwl3SbkjNKUI2TS7bZ4UGeEqtaUGlz23H1AthZNuuU2N5G+xwz26iGss3i+mkpoKqH9OFgHoHPfOfndpO5dElp9loj/jmRSRpfSjqCAFWCyBUOb3zVr/qW9gVkTEavsJ8ktneB6kLh7qlt5AyyfRNqC+hJ9K/xOJi/dGXCLafz0JkKujHoFq9wE2whJ/CqlF2BlZ9SEvn0sW9F41RBCLi/mK9+pD8C1aYV1/Hg+bTwAvsKXM6Hg0o3AALnBqXEhpr1NFY/7o+PFrkVpmb0dxQAIlA9mt00mgle2bzH1id2wKrLOOsa1/G8osilM79p533DuFqrjDOYcM1yt2qT6OXl7OB9yu+K32q5viE3R1M0i9DvewCSFaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OtQFpwRqSUNkuboZQXjNwDdQXKCi06Sn3dbxZb+vZXpNo6gXUyYXlDMaTahP?=
 =?us-ascii?Q?F9r41KSEudkGXlKFvQ2n9w1PqKf2eyDsCj+noxPlcpW4wJ0mYvQcLQ+7RtEa?=
 =?us-ascii?Q?ZsxFsh96lVw+7bShyse2ViRLw1nFkOp4pi5wCwZyYjj11hoDKeAP4lHC/zcf?=
 =?us-ascii?Q?D9hvMYdaPe89O6ovSiXXbhXwqKekWIQZXqTEBuG1f+MUEnayQTpFC9+stExa?=
 =?us-ascii?Q?ywFcJBQG8wIV9tyVj3K24ejnwm4pVa3Lb1vCD64R/Ty9NVmuOWEQYMxVgQUD?=
 =?us-ascii?Q?6GkMh/oIwbFCfAKkgDKd0ftbAJeCFEgulpQ1SYeBpZXeOMtUHRZg2utSSneM?=
 =?us-ascii?Q?oD2JGD5zx5KoeZFLE3c3xghhnDcPRwGFX8xdjthqPXGMNM+Xv5eIwINjp+w4?=
 =?us-ascii?Q?1UdQ6U+JT7dkQ3JGDB7g/R7XWQJxhb5dQaaJjzTJd9v93sAIO/T2xXhdsWlb?=
 =?us-ascii?Q?e8HaIuDYq0CqFIRO0GiJ4qVsdrxPOa/8OagMVCln2yK/yIxZWUxzP58+FYBl?=
 =?us-ascii?Q?fN0eUJarDyiSEUeoHSkOfImve6r/aFCngzDOcpyYhGaiqv8aL8fPaECZ87Zk?=
 =?us-ascii?Q?I62eO8BkLiZK/eanHtF68EKJFtyIpfeTjCNC6swwrsqo8C4FRMDFcMH3GsGG?=
 =?us-ascii?Q?bzoZUEW3Ol7ehNh/n8XAvyCgBsQtp+vhfyYfQY/lHj1OTKMpq4mfaSrutTZs?=
 =?us-ascii?Q?2HcaIkJ1sV9iVEtSIvqJgv0N/D9NKs9nkzxYp9NlW2i3+d5r28kFH2QhE6WT?=
 =?us-ascii?Q?idvPog37NV8JZZpitrNd9LwLi909AM8687NeuT5OCK2CbUYkQSeNeC1RAzll?=
 =?us-ascii?Q?IWyavQqDhnxqalbk7e3QoAyJI4UevT4zI08qmy5Pd+wZLfvHNQKpBlMphjEr?=
 =?us-ascii?Q?5hUX+JBxeuytIeOqtpHpl/YfuX6K86+FT/smX1rR+AIAA6uxZalMAXuXQBpe?=
 =?us-ascii?Q?QbhHCIsdvRoGpRO8lmvTjsJWZVG/49b36guTePhOkGKUhm09e7C5mVV+MthR?=
 =?us-ascii?Q?39TY+5kXMx3VZnSkpFHXbsuqky1bfIDqQm29UTtsKqJvUxqRqRROQ6UR/ySh?=
 =?us-ascii?Q?/9m5fYNqd1fsC78YsaREAfdFAWQRI5SfCDvA7cflna8qsnJ7Ie5MvxTGoBff?=
 =?us-ascii?Q?7tUFR9RnmKnHalPG2jHER/6FxJ2Xwc8SLVW+t49adojTqUENRbbTDLI6r04k?=
 =?us-ascii?Q?fVSOkCGTavB7MNZJbn8sONMrVmFsIjKMC4I1jmIZoPeSnjziaFnID4BiWzsp?=
 =?us-ascii?Q?qsNzidfanxfOj4Pz0ImSmcOyMIdmfWDTOyfSVFiXZ297hiZYs0kKjhM+z3tB?=
 =?us-ascii?Q?Tl0zI+AVo8NOG6sefYGGpmQEDaRghX0KFG/8rp+ZtcEZNEw/w1BWtWyT90kl?=
 =?us-ascii?Q?DJedCKhhyQB4FJXSGY9bFbovJDgYTricv+1Fm0Z6dzsHIvfwX7S9diD9wbKd?=
 =?us-ascii?Q?4c9qcNdDHquxRqW/UQuoENdJCdX2z7xh7JW3jxWzZNqX8hdRsbVH4ucw8Z3v?=
 =?us-ascii?Q?6Uyjmn6y3LKo5mESYSp4PSZ4/G6R5rgEWwPGNzD4JWtycD02Ml4f2zWnd8YH?=
 =?us-ascii?Q?Z2IVklA7wpzpteeCEBjS7QtJ/4q55UvzNGtPiWgZsiUCUqcKB3sjuUqdz0Uh?=
 =?us-ascii?Q?kRDk0isDIYqd9FN2yr63sHaMoPaX3idTDtjf03STuG0AR5GCeN05goTJjPej?=
 =?us-ascii?Q?kA4BZdrgE0UXoveuGcNK6kQPvpUuw/IFIYAm4QrdRBdaRupkfh+H5j9VOybM?=
 =?us-ascii?Q?hzUL8GhiXg=3D=3D?=
X-Exchange-RoutingPolicyChecked: bbqYG5LaZYMOzxHMzitrCw4necGHqF1ccBv0ujdNTTKZ+H1UN9yIHQXNBS1TydXamAiolCe3UpckeJ+JMHBun1v6oJWoez+QjStumbQoWBjtDlOLlQxzJBp1RaEs3pTPYrPhoTkqjQnuIXAJDnSMYCfBCZeesc3JPkyKsFxXAodqzm6pxsqnOqmpouh7J5MD2YCHBsVeZ7JjIqRiSjUsIMx7PVp8dO7IVbTDudWCbGs9BT2ngzeI0v5rjF2JTGfZvs8h2GUrPee6uYGQI83WWI1DbTKZvfvtLjfjGX0+9W4Qvx42Z58tVhYGIagixuD6FLQ75TbKC6jjMGw4zXTwaQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b23f9b63-40f0-45ff-47e1-08de950389b5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 00:12:36.3132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUfdY2U4X0bNqilDf7aNxILG5w4ccEeTXjb5lmFowK+RgylaEusQQfPHI7Arw+3MB+s9LjUYwXmX6DeFxaZtkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

Move the conversion from a gpa_t to a gfn_t into kvm_vcpu_map() and
kvm_vcpu_map_readonly() so that they take a gpa_t directly, reducing
boilerplate at call sites.

__kvm_vcpu_map() still takes a gfn_t because guest page mapping is
fundamentally GFN-based.

No functional change intended.

Compile-tested on x86 and ppc, which are the current users of these
interfaces.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Peter Fang <peter.fang@intel.com>
---
 arch/powerpc/kvm/book3s_pr.c |  2 +-
 arch/x86/kvm/svm/nested.c    |  4 ++--
 arch/x86/kvm/svm/sev.c       |  2 +-
 arch/x86/kvm/svm/svm.c       |  8 ++++----
 arch/x86/kvm/vmx/nested.c    | 11 +++++------
 include/linux/kvm_host.h     |  8 ++++----
 6 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 2ba2dd26a7ea..45dea4064618 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -644,7 +644,7 @@ static void kvmppc_patch_dcbz(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte)
 	u32 *page;
 	int i, r;
 
-	r = kvm_vcpu_map(vcpu, pte->raddr >> PAGE_SHIFT, &map);
+	r = kvm_vcpu_map(vcpu, pte->raddr, &map);
 	if (r)
 		return;
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b36c33255bed..f168b54828bb 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1019,7 +1019,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	}
 
 	vmcb12_gpa = svm->vmcb->save.rax;
-	ret = kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map);
+	ret = kvm_vcpu_map(vcpu, vmcb12_gpa, &map);
 	if (ret == -EINVAL) {
 		kvm_inject_gp(vcpu, 0);
 		return 1;
@@ -1134,7 +1134,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	struct kvm_host_map map;
 	int rc;
 
-	rc = kvm_vcpu_map(vcpu, gpa_to_gfn(svm->nested.vmcb12_gpa), &map);
+	rc = kvm_vcpu_map(vcpu, svm->nested.vmcb12_gpa, &map);
 	if (rc) {
 		if (rc == -EINVAL)
 			kvm_inject_gp(vcpu, 0);
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3f9c1aa39a0a..524607bb8cc2 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4405,7 +4405,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
-	if (kvm_vcpu_map(vcpu, ghcb_gpa >> PAGE_SHIFT, &svm->sev_es.ghcb_map)) {
+	if (kvm_vcpu_map(vcpu, ghcb_gpa, &svm->sev_es.ghcb_map)) {
 		/* Unable to map GHCB from guest */
 		vcpu_unimpl(vcpu, "vmgexit: error mapping GHCB [%#llx] from guest\n",
 			    ghcb_gpa);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e6477affac9a..823c6a6f3594 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2159,7 +2159,7 @@ static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 	if (nested_svm_check_permissions(vcpu))
 		return 1;
 
-	ret = kvm_vcpu_map(vcpu, gpa_to_gfn(svm->vmcb->save.rax), &map);
+	ret = kvm_vcpu_map(vcpu, svm->vmcb->save.rax, &map);
 	if (ret) {
 		if (ret == -EINVAL)
 			kvm_inject_gp(vcpu, 0);
@@ -4820,7 +4820,7 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 	 * that, see svm_prepare_switch_to_guest()) which must be
 	 * preserved.
 	 */
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(svm->nested.hsave_msr), &map_save))
+	if (kvm_vcpu_map(vcpu, svm->nested.hsave_msr, &map_save))
 		return 1;
 
 	BUILD_BUG_ON(offsetof(struct vmcb, save) != 0x400);
@@ -4854,11 +4854,11 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	if (!(smram64->efer & EFER_SVME))
 		return 1;
 
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(smram64->svm_guest_vmcb_gpa), &map))
+	if (kvm_vcpu_map(vcpu, smram64->svm_guest_vmcb_gpa, &map))
 		return 1;
 
 	ret = 1;
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(svm->nested.hsave_msr), &map_save))
+	if (kvm_vcpu_map(vcpu, svm->nested.hsave_msr, &map_save))
 		goto unmap_map;
 
 	if (svm_allocate_nested(svm))
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 937aeb474af7..ee3ff76a8678 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -696,7 +696,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 			return true;
 	}
 
-	if (kvm_vcpu_map_readonly(vcpu, gpa_to_gfn(vmcs12->msr_bitmap), &map))
+	if (kvm_vcpu_map_readonly(vcpu, vmcs12->msr_bitmap, &map))
 		return false;
 
 	msr_bitmap_l1 = (unsigned long *)map.hva;
@@ -2138,8 +2138,7 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
 
 		nested_release_evmcs(vcpu);
 
-		if (kvm_vcpu_map(vcpu, gpa_to_gfn(evmcs_gpa),
-				 &vmx->nested.hv_evmcs_map))
+		if (kvm_vcpu_map(vcpu, evmcs_gpa, &vmx->nested.hv_evmcs_map))
 			return EVMPTRLD_ERROR;
 
 		vmx->nested.hv_evmcs = vmx->nested.hv_evmcs_map.hva;
@@ -3437,7 +3436,7 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 	if (nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
 		map = &vmx->nested.apic_access_page_map;
 
-		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->apic_access_addr), map)) {
+		if (!kvm_vcpu_map(vcpu, vmcs12->apic_access_addr, map)) {
 			vmcs_write64(APIC_ACCESS_ADDR, pfn_to_hpa(map->pfn));
 		} else {
 			pr_debug_ratelimited("%s: no backing for APIC-access address in vmcs12\n",
@@ -3453,7 +3452,7 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 	if (nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW)) {
 		map = &vmx->nested.virtual_apic_map;
 
-		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->virtual_apic_page_addr), map)) {
+		if (!kvm_vcpu_map(vcpu, vmcs12->virtual_apic_page_addr, map)) {
 			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, pfn_to_hpa(map->pfn));
 		} else if (nested_cpu_has(vmcs12, CPU_BASED_CR8_LOAD_EXITING) &&
 		           nested_cpu_has(vmcs12, CPU_BASED_CR8_STORE_EXITING) &&
@@ -3479,7 +3478,7 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 	if (nested_cpu_has_posted_intr(vmcs12)) {
 		map = &vmx->nested.pi_desc_map;
 
-		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->posted_intr_desc_addr), map)) {
+		if (!kvm_vcpu_map(vcpu, vmcs12->posted_intr_desc_addr, map)) {
 			vmx->nested.pi_desc =
 				(struct pi_desc *)(((void *)map->hva) +
 				offset_in_page(vmcs12->posted_intr_desc_addr));
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 484378cfdcc0..893a8c76a665 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1897,16 +1897,16 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
 		   bool writable);
 void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map);
 
-static inline int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn,
+static inline int kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa,
 			       struct kvm_host_map *map)
 {
-	return __kvm_vcpu_map(vcpu, gfn, map, true);
+	return __kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), map, true);
 }
 
-static inline int kvm_vcpu_map_readonly(struct kvm_vcpu *vcpu, gfn_t gfn,
+static inline int kvm_vcpu_map_readonly(struct kvm_vcpu *vcpu, gpa_t gpa,
 					struct kvm_host_map *map)
 {
-	return __kvm_vcpu_map(vcpu, gfn, map, false);
+	return __kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), map, false);
 }
 
 static inline void kvm_vcpu_map_mark_dirty(struct kvm_vcpu *vcpu,
-- 
2.53.0


