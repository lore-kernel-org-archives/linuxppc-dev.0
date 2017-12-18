Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x232.google.com (mail-pf0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0Z2s3hCNzDsFl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 19:29:41 +1100 (AEDT)
Received: by mail-pf0-x232.google.com with SMTP id c204so9382872pfc.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 00:29:41 -0800 (PST)
Date: Mon, 18 Dec 2017 13:59:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Abhishek <huntbag@linux.vnet.ibm.com>
Cc: ego@linux.vnet.ibm.com, rjw@rjwysocki.net, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: powernv: Add support of frequency domain
Message-ID: <20171218082935.GH19815@vireshk-i7>
References: <20171213081937.16376-1-huntbag@linux.vnet.ibm.com>
 <20171214044239.GU3322@vireshk-i7>
 <93cc9d38-4fd8-d340-2263-108329b69b94@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <93cc9d38-4fd8-d340-2263-108329b69b94@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18-12-17, 10:41, Abhishek wrote:
> We need to do it in this way as the current implementation takes the max of
> the PMSR of the cores. Thus, when the frequency is required to be ramped up,
> it suffices to write to just the local PMSR, but when the frequency is to be
> ramped down, if we don't send the IPI it breaks the compatibility with P8.

Looks strange really that you have to program this differently for speeding up
or down. These CPUs are part of one cpufreq policy and so I would normally
expect changes to any CPU should reflect for other CPUs as well.

@Goutham: Do you know why it is so ?

-- 
viresh
