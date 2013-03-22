Return-Path: <timur@tabi.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id CDCE02C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 22:50:47 +1100 (EST)
Message-ID: <514C4595.4080706@tabi.org>
Date: Fri, 22 Mar 2013 06:50:45 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Zhicheng Fan <b32736@freescale.com>
Subject: Re: [PATCH] powerpc/dts: Add qe support for 36bit
References: <1363857961-23296-1-git-send-email-B32736@freescale.com>
 <CAOZdJXVs9My50m9KHzdbn6pjvhvLqHrqqMsK02z2kCFx8YB03w@mail.gmail.com>
 <514C054E.4080102@freescale.com>
In-Reply-To: <514C054E.4080102@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Zhicheng Fan wrote:
>>
> Hi Timur,
>          you are right ,the QE can not support the 36-bit , I test it on
> the p1025 ,the qe can not work
>          but we need the qe node , becase the dts include the
> fsl/p1021si-post.dtsi
>          that needed, I will send other patch

My suggestion: with a 36-bit device tree, the QE must be disabled.

	qe: qe@fffe80000 {
		/* The QE does not work with 36-bit addressing */
		status = "disabled";
	};

However, on the P102x, there may be a GUTS register that stores the upper 
four bits of the QE's physical address.  Your patch *can* work if you 
*also* set this register to 0xF.  Look for that register.
-- 
Timur Tabi
