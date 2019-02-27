Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EC8C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 16:19:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD5320C01
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 16:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD5320C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448gr80phVzDqMb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 03:19:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=paulmck@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448gpM6NzTzDqGB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 03:18:16 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1RGF3TV120411
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 11:18:13 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qwvr9ve43-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 11:18:12 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 27 Feb 2019 16:18:11 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 27 Feb 2019 16:18:01 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1RGHxB38978600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Feb 2019 16:17:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 644DCB2065;
 Wed, 27 Feb 2019 16:17:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17D80B205F;
 Wed, 27 Feb 2019 16:17:59 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 27 Feb 2019 16:17:59 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
 id D4F6616C42A7; Wed, 27 Feb 2019 08:17:58 -0800 (PST)
Date: Wed, 27 Feb 2019 08:17:58 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [RFC PATCH v2 09/14] watchdog/hardlockup: Make
 arch_touch_nmi_watchdog() to hpet-based implementation
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-10-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551283518-18922-10-git-send-email-ricardo.neri-calderon@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19022716-0040-0000-0000-000004C8DD4C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010674; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01167172; UDB=6.00606765; IPR=6.00947783; 
 MB=3.00025768; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-27 16:18:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022716-0041-0000-0000-000008D3E51E
Message-Id: <20190227161758.GE4072@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-27_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270110
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
Reply-To: paulmck@linux.ibm.com
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Christoffer Dall <cdall@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ashok Raj <ashok.raj@intel.com>,
 x86@kernel.org, David Rientjes <rientjes@google.com>,
 Andi Kleen <andi.kleen@intel.com>, Waiman Long <longman@redhat.com>,
 Borislav Petkov <bp@suse.de>, Don Zickus <dzickus@redhat.com>,
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <frederic@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ricardo Neri <ricardo.neri@intel.com>,
 Byungchul Park <byungchul.park@lge.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@oracle.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Colin Ian King <colin.king@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 27, 2019 at 08:05:13AM -0800, Ricardo Neri wrote:
> CPU architectures that have an NMI watchdog use arch_touch_nmi_watchdog()
> to briefly ignore the hardlockup detector. If the architecture does not
> have an NMI watchdog, one can be constructed using a source of non-
> maskable interrupts. In this case, arch_touch_nmi_watchdog() is common
> to any underlying hardware resource used to drive the detector and needs
> to be available to other kernel subsystems if hardware different from perf
> drives the detector.
> 
> There exists perf-based and HPET-based implementations. Make it available
> to the latter.
> 
> For clarity, wrap this function in a separate preprocessor conditional
> from functions which are truly specific to the perf-based implementation.
> 
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Andi Kleen <andi.kleen@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Don Zickus <dzickus@redhat.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Babu Moger <babu.moger@oracle.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Byungchul Park <byungchul.park@lge.com>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Christoffer Dall <cdall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Cc: x86@kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  include/linux/nmi.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 5a8b19749769..bf5ebcfdd590 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -94,8 +94,16 @@ static inline void hardlockup_detector_disable(void) {}
>  # define NMI_WATCHDOG_SYSCTL_PERM	0444
>  #endif
> 
> -#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
> +#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF) || \
> +    defined(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET)

Why not instead make CONFIG_X86_HARDLOCKUP_DETECTOR_HPET select
CONFIG_HARDLOCKUP_DETECTOR_PERF?  Keep the arch-specific details
in the arch-specific files and all that.

							Thanx, Paul

>  extern void arch_touch_nmi_watchdog(void);
> +#else
> +# if !defined(CONFIG_HAVE_NMI_WATCHDOG)
> +static inline void arch_touch_nmi_watchdog(void) {}
> +# endif
> +#endif
> +
> +#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
>  extern void hardlockup_detector_perf_stop(void);
>  extern void hardlockup_detector_perf_restart(void);
>  extern void hardlockup_detector_perf_disable(void);
> -- 
> 2.17.1
> 

