Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA93606A32E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jVSPpolz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLPDK3Lkrz2xqh;
	Fri, 06 Nov 2026 14:04:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793934289;
	cv=pass; b=h4toS7VGjjOax9ByAFHu8118WF5OUAdmEHQ3/Va/APl8kZdvhpsVMeuRNbHDHUGkYwYv+Y+I+GAXUvqDdyxqOj66TzIjgK2P1zXoctaFkf5Rkz6cV7TCdqtRzRs+uNmnVrx1e0f4NMNamucwIn522LJo6y6xw6Yt4pSBL7nAaMPuGFNAhXyjeRr228nFyqWv650kFPFbA5O0djDREv4DGLT+suhTlhOuUUP5yvfu1ILaHYkPjTIetdwz09URbnrMCg3La/yBqOFbkXNgFSUwGolpOf2uhQDV43F6hNPt+pK+aUUtHHBygG8ZwTbdDlnVgO6aN+v7BfIX1Tocg9JosQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793934289; c=relaxed/relaxed;
	bh=wrOS4zcZPhwmUQqqAD1I4FSRc8tgpRNwmJ2j3smD0L8=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=oO7WXS1vtDu/drPFFk+L+EU7sLywQRWIfQTIw8KNZ4wt0IRtYseBYWdgaOUdR4zLjINIr0iY3chFRxSuIun3oqZiTpULVfo3DoS3sDPx5Xdl4rkTRg2hk7Ax38v5qVmPEEgkZNYOli5xRnbY2AXnpm4ebNWzpCTwRF7TyzPM19e9vUytv4xvxzjVnKqWF0j57p+L2sSyu2ObGCMMcz+8A32UC+eIltIpds8gW4nzpXLtzuZVzbz8VWz8k3NQk+arYb6s523YxmxXOCneoz1ZlK3ghbEXKZ1yCtBj1uvSO8QklKklUxX+SpuZGIvr1T1awS43YXJTeud3Qe4D8HwMXQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jVSPpolz; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jVSPpolz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLPDJ4bZ0z2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 14:04:48 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdxowHRDIw6xDC6iWGwCS8edZDYvnbpwkSP2Bcztp8ywnAA2YCWy0S+5j3H80TbnlYb4nuAVI7UbFH4xleE5EDvovVFzdi5gvIN6amiAP7VRt/dTSsc1hn46hxhQdXZHcKdjhYQPAhNyRr6jCjN5P9vh3vXCZCDcy6fOVyYefkSrM6AT/RnkW2TQr39CNdszR0RgUK3HqgJAj5ws0jeZv3QYfmtXUvbF413HG4iFe4M/nHfEhovHSDnkZ5TRbWMba7g8nDsQZle7xPEEmoLu42zZlMdonoS6NMu74nj8Ar49DCWzhCurGaiaflKM3OJCj/py08FrofrtGWkLu+A9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrOS4zcZPhwmUQqqAD1I4FSRc8tgpRNwmJ2j3smD0L8=;
 b=LX9Zg+4jQvlBDkrtvDAcjpkJgoGHbwIltvB2ej7L615ttgB756ev3uPqwn/wQ8i9YMhngSxj94jqblDx0l0BhYBWKL52c9xpAQNKsWEUNTp+HbpKmuBVXl7VU2X374debQSSwEYlhT9LD7sN5YnS6MgIUwOde5lI1ulFWWFug+J+8y2bmaZcFBpvTNt2AP15pmdVX+ZaX0gFkmNbxGhNhGjOwt3ew3eH61R+p775yP2jx/OYnE+H02p6V/qKRglwUQ0lCMY02OWAO9oYizycgcbCWTNAIARUo9iaK1j+h03YEfJrECoPc+AvWdWsC0lbVrHWBNQRtoaBSGTk3NUwdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrOS4zcZPhwmUQqqAD1I4FSRc8tgpRNwmJ2j3smD0L8=;
 b=jVSPpolzn0fhUnEwwVeZ6JRKTMb0F5qjGlksP1oZl1W24o1y0DDVvfBbUkSEw407vI9W7yC4dNpeF/etnrQAvcqz43UeDQLEDSPzii7od4K+9AXCqxTqgf7c2XxCl6GZn+yJ2RP2i1npMklZ73XBSpFNXzrBjU3Em5it+PBmk8i57E5DZx2Eey7OLt9aaJ8QlrA8yYE7f/5WN3ajYFpmtGfp60JO8fA+0DiX/Ss+cWGcN9KVM2nTR/1V/JyWbWRD4ClVdhDb6/mz8zc70FccibaHR4g+Z+Ian3YC3K2S5Vpl0UTAOSj0q06ohDbokeEIZp9ZB2Z2TLUduy9dVPoS+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 03:04:24 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0592.007; Fri, 6 Nov 2026
 03:04:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 22:04:23 -0500
Message-Id: <DMNSMFH1W66H.SFI19PO6JKJL@nvidia.com>
Subject: Re: [PATCH v5 2/4] mm/huge_memory: copy file THPs at fork like
 copy_present_ptes() does
Cc: "Alex Williamson" <alex@shazbot.org>, <kvm@vger.kernel.org>,
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, <stable@vger.kernel.org>
To: "Konstantin Khorenko" <khorenko@virtuozzo.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Hildenbrand (Arm)" <david@kernel.org>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <liam@infradead.org>, "Nico Pache" <nico.pache@linux.dev>, "Ryan Roberts"
 <ryan.roberts@arm.com>, "Dev Jain" <dev.jain@arm.com>, "Barry Song"
 <baohua@kernel.org>, "Lance Yang" <lance.yang@linux.dev>, "Usama Arif"
 <usama.arif@linux.dev>, "Kiryl Shutsemau" <kas@kernel.org>, "Peter Xu"
 <peterx@redhat.com>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com> <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-2-c56d0d26f970@virtuozzo.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-2-c56d0d26f970@virtuozzo.com>
X-ClientProxiedBy: BL1PR13CA0232.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::27) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd259cd-d951-49ec-f6e9-08df3bb2a96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|10067099003|18002099003|22082099003|921020|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261013131602099003;
X-Microsoft-Antispam-Message-Info:
	iZh933GAaAjVpK53oMfRM8THGOjFV1s5nGQxGLNXCxMT2KYtTKTdoC8j/v3MIBRdFwcV7z8QOaf0+uWEjULPZfOXsi0c1bkdsDyKcfd/VU1bEFyU9wT42395K20vIS1unFq3m6gIBNmdPB5FR5EPoNwc3By5n19onhRzA2D+QGoTu2WB33ep4ix8X0ZZx5GAmCDztsncTErcoxJe8a8TN/12cw1OFLeVRvJDErFrH27P4lMIejEUkmhSFOK7rYU6exSR0ZDMrpv/mRQielSfVKUei5TB29AESteFh2TKH+C+VluAkF2Tv7g9pSC4DvxeeReDCHrf0a3vU7UroQOP3oXf1AddZzE89jqL+8kgC+SMZJ4NEoDR6PD73gUBeCXXfQ7YXSXvBM9axbTIT9mGSBmxaMB6yEq4T7VAuvict7/4Z4YRgDGYgSynBU3g+ZL5WXMBP65UYu9b0+bSXhrDkAqQ0XqfKvCXEc6W6J1gg/jXIW3B0GHaEhSP9cb4vEzT0uFe0GIcO6q8qD9X8uCreWqG3wN75+eemWw9Ue5ubJ7l7wUdLTG20dl3pifrKEX3JTfHqNfC2pMeRy4oW6AG0Q6lDel9W2OpfqyLKdR9aQRJvhRjLv1O5w/rWSZ9D5qjY/xztDmn+KE3mVQBfB0P3TcfbghtbIV7VB8vCp5sXHBLFMTak6r8dqIS6KD8t5CX6B158FPQDxdp75JxNReslQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261013131602099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ulo2VGhnUVhadW8vNVRQSzZ0UzI5dHlkTitNY3Z2dXBwNEUxcEhZR0FuSUdv?=
 =?utf-8?B?RHd1aHRuRm0zZXJ6K2ZGYkx6bjNSWG5sWXFjdk5CTTlLdlNVSSt6SitRUy9G?=
 =?utf-8?B?dVVkeGcxTVlaU3FPbHluelFsWEdSRWp0Z0VlOENuaGNQeEZaQmlQM2U2MDAy?=
 =?utf-8?B?TXh6NTZPRmpJdnFHUVVzbzI5dGtTTkhNanpvMWtzbDJ4SXRHL1BTUHovQlBT?=
 =?utf-8?B?a1VpWGoxeEdUSmhHeW5paUdzMGh1YjRDeUM3VFdmeTBLc3JDTlhTWlNjUklQ?=
 =?utf-8?B?eFUweDRUZkRFUzQ4YXhxMzlrYlhJUVFoOWdxaVhjcnQzNVNnZElXOXdYZnZG?=
 =?utf-8?B?ZEdIZ1gwblIyZUgxcnZBMGdEcWFoekJOcVRPcW16Rlk3YmVzYjFDSHRwMndr?=
 =?utf-8?B?Ri8xbW5adHQySmJoMU1NWGk2eUNYbWsvVStxb2lUWFNmOWU1Q2c1bGFraDh6?=
 =?utf-8?B?VVI4bng4cHdZUnJPVVR6Z2thY0lHcGExZUdSeWJFbXJkUGdrWDkyVmNmMkRt?=
 =?utf-8?B?aFU0dWh1YXcwQkMzK2FKL3RNdDdmaHJQWVkyTE1xcHZzMExNM2pkLzNqOWIy?=
 =?utf-8?B?ek5WbUtrNUVOb0V2M0F4U0NzeU8xMTl4N0d5SXorUkFTOUlpNnFTWWRkaUN0?=
 =?utf-8?B?S0NmT3A3a1RSeW1iTmRyYmF2YStHYUtDYU5sZFlaL01FczdLU2c3NDg5QkJz?=
 =?utf-8?B?bjQybjhFOFFNQzk1VzhnQjMvaWlGNWI2L0xZcG1OMlFvQWZjMEpDZ2NsT0lZ?=
 =?utf-8?B?UUg5Z3ZXSmFGUkNUQVgzOUhhbW9vdmhpdVB0cjlEb2xwaW53VWc1NE9zT3k3?=
 =?utf-8?B?VXNwa0twMkZkbERVZXVwajQrYldvY2VIeTFzWC84SVBEUjM2cXpReDNYc2ty?=
 =?utf-8?B?ajNyM3QvWmJiQ3dYR3hXWXhqaSs3Nk9taVFRVys5UUV3R2ZjcktEMGJXNzVD?=
 =?utf-8?B?MlFzd1NHcHBCSWZjWDN5TC9EQkpmbWxCNzlleXJFdmxkRDY1cmdFSW9abUNh?=
 =?utf-8?B?bmdvUkNQd21jRGJGNFhlTWhrdXRyaFFTY0NDNlNBTFcxNllUZklPcGUweTgr?=
 =?utf-8?B?V2pUWW9jYkNWa01uR3c3dFFzMTFjWFRLOU5TeWRZVWxpcU1KcllpQTk4S2Jy?=
 =?utf-8?B?b2pidWNQSWJNWG1HU2lpVW8vLzFreCtrUll2UkllUjBET1JUUThRYmZja2pF?=
 =?utf-8?B?SzV2UWdZSU1GZEJjQ0lXY05qUWJ4WXQrbmlYcVZiYkoraTJEV0tjZWNXR0tB?=
 =?utf-8?B?OW1aNE8xSEh3UlF5NHp6M3ZOcWJtTmlTb1J0V1p4UWFKdWxGVEhvNW9meEZr?=
 =?utf-8?B?NGlhdHFLeVRwR2RBclFKZEY0U3ZCVGtkYmxMd2pGMmVoT3BsRlE2SGNOVjhC?=
 =?utf-8?B?dk1aUDZYbmMzYm10dDBtSk9vdHc3SG5XeTNiV3FMMm1UYmVMNmFMeGlkNVZL?=
 =?utf-8?B?b3g3NFhFcGVES1VhMXV2YnB5eGlCcmxSS1lpYUQwL0hrTzkzalYrektQVWxS?=
 =?utf-8?B?Smt1d2dOdmhKaDZpa0Q3WGtoN1lTbDhSTGFUa1dsa3Q4dDU2UEV3UDlzdEpX?=
 =?utf-8?B?eGtNbXRJdDk5S2djcUxTb2c5b0hzeVlkejhOR1ptT21uTmRQQTNqUFhSUDlI?=
 =?utf-8?B?NFloandBSG43c0xuR2dkUzJxSmFIMEJRVmlWV1BnZWhhZm1tRERtME9hRHcv?=
 =?utf-8?B?U1haY0VOSzBmUVNVb2dsWERtZ0NHcDR5YmRraDdRaWlKVzYxZFF0UEFwOXYy?=
 =?utf-8?B?SUdjV3gwRTdRN2d3c1poREZzRXpkTVUxSWg1L3V1MExHNnNLU00raGxFRHMr?=
 =?utf-8?B?bkdDYkNwaVF0TWQzTVpRWWhXd2U1YXN2QTV0N01zOHpaQ0lqUjZNZ1QyRXVa?=
 =?utf-8?B?SVZ0eFNFNXJLcGJLTkNPcVNNcFFrL1pUNS92c1g3MFpuYnpHV2xLU1QxWXJo?=
 =?utf-8?B?bUxiRVVndkRwY21VMm1aQW43cDJNMHY4UCt0V0J0MjB2cnRpU29ncVlGVUJ1?=
 =?utf-8?B?K2ZhTmZ2Y0pucjdWTVNxZ2p1VjVHOW9sWU44TzJPYlc3YnNjQ3ptVHZFMEdV?=
 =?utf-8?B?NCtaUjZhWU9sbkRkWTZhbmZ1b0JtTjltYU5aZGpST01zM21xd2FGNGNhVFJS?=
 =?utf-8?B?bnlaRlA0M09tMFh5WkxZV0dVbXRzc0w3VjVaNDhEdzk0c2liK1A5Vk5SbGRu?=
 =?utf-8?B?M3V4aUNXMU9hdEtmNFV6Tk9RZnAralUzaHlVVmc5RlBnWEdUVU1sZ2RNQTV0?=
 =?utf-8?B?QTdPcjFlZllPZXhJZ1ZoS2tISHhOZXNkVDhMenpRRFVwQmdZcGs0R2tjTUFm?=
 =?utf-8?Q?bDLz/kiN14EC5j6el3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd259cd-d951-49ec-f6e9-08df3bb2a96b
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 03:04:24.4184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1ge9I7mrvkDl/b84dPuGsYlvwMJkd80qNUTV7lvgNa4ElV1DJ+yBPks0xl2ml7y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Nov 4, 2026 at 3:40 PM EST, Konstantin Khorenko wrote:
> This fixes no bug: it makes fork copy a PMD the way copy_present_ptes()
> copies a PTE. Until now copy_huge_pmd() skipped every folio PMD of a
> non-anonymous VMA and left the child to fault them in again, while the
> PTEs of the same VMA are copied.
>
> Treat file folios as the PTE path does: take a reference, duplicate the
> rmap and account them. fork then pays a reference and an rmap update
> per PMD, and saves the child a fault per PMD it touches. The next patch
> sends PFN mappings through the same tail.
>
> That covers the VMAs vma_needs_copy() sends here:
>
> - private file mappings with an anon_vma;
> - VM_COPY_ON_FORK ones: uffd-wp and uffd-rwp, VM_MIXEDMAP, and
>   VM_MAYBE_GUARD, which shared shmem, file and DAX mappings get from a
>   guard region.
>
> The DAX huge zero PMD is copied too, with a reference taken by
> mm_get_huge_zero_folio() as for anonymous VMAs. A migration entry of a
> file folio is copied and accounted like copy_nonpresent_pte() does, and
> made read-only in both processes only in a CoW mapping. A device
> private entry gets the same CoW check, as in copy_nonpresent_pte().
>
> The copy then gets the same tail as __copy_present_ptes(): write
> protect both sides in a CoW mapping, mark the child's copy clean in a
> shared one, and drop the uffd-wp bit where the child is not armed. An
> anonymous THP is now write protected only when its PMD is writable, as
> a PTE is.
>
> A page table is deposited under the copy where the fault paths deposit
> one: in anonymous VMAs, and wherever the architecture needs one.
>
> Cc: stable@vger.kernel.org # needed by the next patch
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  mm/huge_memory.c | 63 +++++++++++++++++++++++++++++++++++---------------=
------
>  1 file changed, 39 insertions(+), 24 deletions(-)
>
LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi


