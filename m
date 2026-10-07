Return-Path: <linuxppc-dev+bounces-29018-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DC6CA6002
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 00:19:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0VwY3mShz2ygK;
	Thu, 08 Oct 2026 11:19:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c000::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791399521;
	cv=pass; b=evIb7Rg2gNxUutTx8P7A+55wHaOMR8G3TW5TljwgwAKVNhVM+SjsRD63NMnBeE0ih0PnH659oHej+ECnxXszr9xPplBnrXzLgivcxWR7CKsucAOKyVjQbL4/KoH2QCqdfK4Z6PfP0ojCvXqJOHuQkULDXqNKBpaMnwLF3cTk5xnbcGhetjURpCp+Xxbs5vVdU+EJ9Kta+xiP+TXWpexWcK86Cb/juB3dQXZtdUc8HRRlA7Su3L78Rx11JcZcITsw/XMBxkvAHeV2j9aCIkSrJ++fdknAIyHNQjbrIgDpva2LhP2bCZUBfoE4J6a7br9kZH8uidfcVbexnvNTB66JPw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791399521; c=relaxed/relaxed;
	bh=UNTBad831l2/inXBznQ/GDVm005QmSgHz3Tz5Ypc0nM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dDlKt1mKGS2Qb9erH460yc7E25rkPj/Civx4Iq9IakcoLeMFCM60mw068mq3M8tdbIB7AYxEKgcZLeoB5jU0Dy4mG3YA2IOc6M86FcWzPLxAdLfkn9U2c3HJqNXf2RWVg54oFx8DG9f/r8iBmgfIAAsKk+q2QO0c4HirX4DMCj9ySnA0edFuhS38prLRx171ZT9XT0M1LIpHCg9Efq6T6DWQJ382b1CumNLL+gu6oYHbCgoVACQm/QNAz3Ez+i+/rQTdkzoTY1qtb8jnYb4pZpvjxRU/l6vEZZR9VGo3RgHEU3eqjNjSd7QCSahb9rahMwt7JnlKgCcKfHV9dfyNew==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oAOhUaJw; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=joelagnelf@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oAOhUaJw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=joelagnelf@nvidia.com; receiver=lists.ozlabs.org)
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0Mpm5CBJz30Cj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 05:58:39 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diZe8xMi+e34p5RL6niL23UveGkQrUEYa26x3TOMPCmP4ozgYk/E28DKDbTPinLvi83fJYpzcj+TAJ7GgwlcWecFxaqkE5a8C30QEChebjluqbY+mSh0KUpM8R6wQTLtiiUo1VRFg62/0uY7XFiYNlx+N/ZyGFiUPieuSN3tjrC6NOmF+dM/sqTXg5O3jTZFAjKYm5+trirsg4PNmodkYGtHpaBS2YpuMsFfr+Ol0jlxeutWPe2v1dcPbg3C5i5DpGLN+2/zWx3ESP2b3wniQZGZ8XCv88epqjSHTwh5ia7lCDht7cQKV97rSBAhQGWsQLxwoee9Se6yVBDfso9rbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNTBad831l2/inXBznQ/GDVm005QmSgHz3Tz5Ypc0nM=;
 b=yexhBcshC0G8/zr0FjJ71emRCWXHUbnJYW/cGvwBrBScvvHrZ9YTwf2O/5KJgz4TyONrmSZJsyqrf80W6Xx1AJUaQw2VZwMcc7i2mN+cljCKLN1gYEIDLKcvqbwyN/joXkFHYKbsRR7ogXjgKeB9sEWFR8pvd+glvKrOfqU1lTTIPlCH55JX8Vegvfcep/k3A2NTP8CyTpM/z/IZ6CuS2p3yMlANCvD5DZk2omE4Pl5ke4LrhStFNG+v3KxL85/QKZ3qJvRTInAtozUi2KOuImmdsdRxSLqWLisPWxWk2nF3S48IrH2xTG0iqpKfbyTkGqa6JSSQtiCqL7fNcku18g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNTBad831l2/inXBznQ/GDVm005QmSgHz3Tz5Ypc0nM=;
 b=oAOhUaJwuoucyKU2DqH2tdp7FV8JBqCfJ8HRFB7m/0BPMSUiD88gFhXJsSMEetz5zkV76OIKlJUDxbN8XkI6QyF7rmeQx7OyB6uqBwcWb1SaEUwZiBAbXMVlbkSK5Gks7HH9yMPfnhut3hX0GUBonw5i6+X3qdBh56civHQUBa5dhimIaZUiMh8VC2OeUbeDm0JHHhcw0lMX+cejvSrD6Pb0GnjkS9aCAmczu6brxO4nogWbr+p80eWLiAV6FQbKYIZuNplAJXNjWRNIhoqpDbHt6LuCzpAZADXNUyd6NawYZBe8aufu2nXtMcw/YPvwyMX2xldFLT4s5Z7i72Mv5A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 7 Oct
 2026 18:58:10 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 18:58:09 +0000
Message-ID: <038a4b64-3f7d-47f7-9ba9-a962c265e0e8@nvidia.com>
Date: Wed, 7 Oct 2026 14:58:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] rcu: assert static storage for RCU sync and SRCU
 definitions
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@gentwo.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, Kees Cook
 <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Mike Rapoport <rppt@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 virtualization@lists.linux.dev, linux-rt-devel@lists.linux.dev,
 llvm@lists.linux.dev, Yury Norov <yury.norov@gmail.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915031334.1194975-11-ynorov@nvidia.com>
 <20261007184105.GA3837481@joelbox> <asaUECwON5PS98M8@yury>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <asaUECwON5PS98M8@yury>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0051.namprd04.prod.outlook.com
 (2603:10b6:408:d4::25) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: cf668440-b0e8-43fb-bf25-08df24a4ee0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|56012099006|3023799007|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	421eAfrguhnyzMb5VnpgE8yWymDanFTnxgGUExLCMmwXuI4rTJlW8Px7jH1giYUmKNFdjnArWNOuIaorrI1YwaTWGPoHdDvXH5A4OAVEE0Hyzo3L4FKULLXFmd8BIpY52YJ27HFCJzg2zoWrvHkf8D/z3+cKkkSH8+UvOlEXOsuq55VuK2a0YXpGhu0x18CGPDn60HKnnYqsSqyLeQz0T0I0ntbL8BNiqaV82kPVAuaQRn5ajmZSdRKqPhBSqdXDpeNi2Q6zQ8Hvqw2lq2iQaBzH6OpceovjXrusQ8lNAJQfgNVxwlPciyrvgR1PaBFkuPqZd+MEuMIk/SrUL9n5+L5wPEU4gzeWji22KRVFjH6IzjGph8i7mszT0u+xk5ULaWyChK+xkTBIePPg+wttscAE/f5dCeJevwQG5zgQbQNJ+5BwvE56hKZbnCGC8/z/4BKpqUuVUoNao402zH8dyfAQ+Gh3A3ega/1DOOgqtSzmWUeM4XjovCcvmXA4bjfhRkyxhdnX8YRiCkg8Fwwx+HKtuAI7Tl4P/t1M23GyN17euY0lTBTuTC0zLg/mUEEMwo/F0PnQLkvg0DWLEeOSmg7A+vSRolCAr4VDk7dsoLHOwMdZVgvL+UPJB7Wc2/xeJrS9bxhwt5pt3pChueFIqYtK+dulAxdW3rPfzY8nzY8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(3023799007)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U21QRUt6UXA4QktJV2Y3a2Z6dTlDdDNRQkVQMER0bnB2YWwyWW9mdU13MVZx?=
 =?utf-8?B?anBNYWpHWlZpODVIaXp4S1Y4UGgrN0k0c2lzcUUyeHVWSXpjOFR3TWpvR3Bx?=
 =?utf-8?B?aERqYitFT0lyRi9NVStwcFlacytQNVA3QUpVVFl4NVFkV0oycTFoUnVOTFFW?=
 =?utf-8?B?bWxnb0VWRzc4VDJxdHpwK2hmREZlZWVaVTdsWnI1OUJCcVZLeGlPWEdGcmli?=
 =?utf-8?B?anZ2dmc1Y0U2eGE5eWNuMS9TeGU1YXYvM2EvS24wdkRoalNMQXNsa25KUEFF?=
 =?utf-8?B?ajJLK2JEdDQ4K0xyM0ozTHpaSTJ1ZE1OMHNEYlJzN2lEamk4UmtwU2xFYXRy?=
 =?utf-8?B?RkJkU3ZhZysyMHMzNTZoT1hmOTIxUUlVVlBHbHJ6am5VbTFQSCt6bGNxckFW?=
 =?utf-8?B?S01ENFlyV1N3bmx1a0pObEVPSHI3N2ZwOHp4emFpYWlJMmxxY3ltR2U0bFFi?=
 =?utf-8?B?clMrdFJsRHo4ZW96b2piek81TVFjQkw0bXI4ZzNrblpOeTlXRXZJWk4wVG5E?=
 =?utf-8?B?bGc0VkNCMlFBNW9uNzFGK0hMT0JHRWgzQlRxOGM2K3N4ZjkyaS9BTHorQ09y?=
 =?utf-8?B?WjNyZzRYcjBnNXVGQ2lyTEpERW5rZCszZjVjT1ZkZEV4emdZZlZuNlBFTjJW?=
 =?utf-8?B?QjBMY2NCK2oyTHJnV2l4ekZmL2w3VjcyYUZEVDJGSUNpQm11VDZnS3ZDSUNE?=
 =?utf-8?B?NStVdDFicVdJRHVlc2ZRbE1lVFBYb0YxaHFLWVgvT2orYkJVbjZEY05XSU9Y?=
 =?utf-8?B?UTcvQXA2R0ZoWEJkaHpDSnVWU1E3UldZQVErYjN5MDQ1Ykk1VllZVHN6RmlY?=
 =?utf-8?B?MDRvNndZSXRRZFUvSkJWZ1ZiMXhJMEhSckZKQkM4ZThxSUE3aExhMkNzTWM0?=
 =?utf-8?B?bS9mdStWR09XSDgwMi9CYWdnamhTK0FTZGdMc3ZUaFBzYVl5K3A2aHdzcG1k?=
 =?utf-8?B?SGZibCthTnU2SEd3blhPT3hSbUxXUVBLTmhmSU1ISFY2SkdmWmJOVXpPRXFk?=
 =?utf-8?B?Q1YvZllGS0FoYk80VXhWTm9yUUZWOFo5YWFhdXlOK3AzQ0Q3TmdWamw0ckFl?=
 =?utf-8?B?OXdiejVXMUV0TGJseGJXUDkrWVdIYlRjcVkxL3Q3NFFERGNzUEpiOU14Yk5P?=
 =?utf-8?B?OERPTm4xaGxGZDdld0M5ZnJvVExiNytzYWhkU1JHcnZwbmpkaEFVOUxSaHc5?=
 =?utf-8?B?UVdFNnVHa1R3UkxnN3p1RUNEam1EYmV4MzE3b3o1Y0tBcUVIQWtzY294ZnJQ?=
 =?utf-8?B?WmFmVmRiQ01aR3BOZHRIOVowQmxyVFlhVEUwZXpnYzZ1TWJWNGtOUUFqR1JU?=
 =?utf-8?B?cnJCU3QzM3ZvMU9TaWdrVmFKRmtvZDJtRTJ1U0YvS2VySUs4YWlFUE5lbWll?=
 =?utf-8?B?TkFJODEwNVg4M0lqekV6bHp4ajRSY3FEVFpidS9rM2trZEQxL0NnbVNtU3g1?=
 =?utf-8?B?b2ZUdno4dm5zbUdKUlk4aFlpcFhtUFBJaWlaeXF2eGI4YTAremJibTVTRk9n?=
 =?utf-8?B?a2c2cjJZdWNiYU5WMWpsY3UxZ3Q4L3A0L2lMMVhTd2YyZTUxWEgrL1FKcUR0?=
 =?utf-8?B?WjVqVE9BQi9JMlBRNHozZVF4R1NlMElFa09XS3laeE1DTjZONWI5Z0llTmJ5?=
 =?utf-8?B?K1RFaThOVmNWUmpGeU91SU5XNEpJUUQ2alZoMHRzQ2lkcmMycWFsaURZWFIy?=
 =?utf-8?B?VHh6c01tVGgzdm52WlllRGJTY2VTbG42K21lcHdPSFZaNmhDWXlnMkt4OEZl?=
 =?utf-8?B?dElBaFlOd0JRWXRwOWFyRGZsb1oxcm1IVWYvS1V3bVBmTDBlOFM1b2RaQmxD?=
 =?utf-8?B?KzRmelNNVGNuZ095NHpvYy9aSlcxUWJjdFpkSWNUek1LK000VkowU2s0OTBp?=
 =?utf-8?B?bDVOOUJUVGxIQVVIaUN2ZkVFdkJyVGlsNWtJSGZ5aWlyOElrVkFETnF6M0Zj?=
 =?utf-8?B?cldUT1p1ZXFMdThXdDdJOVdnUWl0amd2cVhPMjVBY3ZNRFlQRUR2Y2dXL3p6?=
 =?utf-8?B?TVhlbTlIQUpqNDdrZk8wNGh2Q05ubU1QM0swL0Jlc2lMR0pWZGpqQ1RCemhn?=
 =?utf-8?B?cUZHdDVyeHZRdit2Yll0eGcvcVFMRkFZci9FVWJ5UmxualNuYlJnclcxTWZz?=
 =?utf-8?B?Q29LZUxOMmVseXJYUTRvRGRhaCtVZzBMQUJhR2ZJVVRrRzg1KzJ4UmNlbTQ0?=
 =?utf-8?B?Z2RvaUVmQlkzZDdLMWMzSW5qTE54VmhMZ3BYR3hDbVlhOHFMYndsTk9jOEpW?=
 =?utf-8?B?ZktibUZoeXVKSm1pNVRHeGpMOE5mL0c2UUcySk1nKzl6TCtFN1N1dEorQVdR?=
 =?utf-8?B?SmVkUFYxbkRwSk43TFpMelp3M1A0eWxaWmZXYnJTOS81dWI2aXZWUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf668440-b0e8-43fb-bf25-08df24a4ee0f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 18:58:09.8614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWeCOYfpw2qqy3ftpTMrz04yc6pmjptUYgQ/QNA12Fn2ybkYus4tgKDiPvUCa1kWIWsaP2xssmwjFW+gm8wsGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723



On 10/7/2026 2:48 PM, Yury Norov wrote:
> On Wed, Oct 07, 2026 at 02:41:05PM -0400, Joel Fernandes wrote:
>> On Mon, Sep 14, 2026 at 11:13:31PM -0400, Yury Norov wrote:
>>> DEFINE_RCU_SYNC() contains a statically initialized wait queue. SRCU
>>> static definitions similarly rely on persistent lockdep keys and, in
>>> Tiny SRCU, a statically initialized work item.
>>>
>>> Add ASSERT_STATIC_STORAGE() to DEFINE_RCU_SYNC(), both Tree SRCU
>>> __DEFINE_SRCU() variants and Tiny SRCU's common DEFINE_SRCU() declaration.
>>> This covers the non-static FAST and FAST_UPDOWN wrappers too. Tiny SRCU's
>>> explicitly static declarations already enforce the required duration.
>>> The existing per-CPU restrictions on Tree SRCU declarations still apply.
>>>
>>> Assisted-by: OpenAI Codex
>>> Signed-off-by: Yury Norov <ynorov@nvidia.com>
>>
>> All the changes make sense to me. I'm ok with carrying this for -rcu 7.5
>> unless you want to take it.
>>
>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Thanks Joel, carrying it with the RCU branch is the preferred route IMO.
Ok, applying this patch for -rcu 7.5, thanks!

thanks,

Joel Fernandes


