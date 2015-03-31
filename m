Return-Path: <fbrozovic@gmail.com>
Received: from mail-wg0-x22e.google.com (mail-wg0-x22e.google.com
 [IPv6:2a00:1450:400c:c00::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 485E31A0739
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 06:59:11 +1100 (AEDT)
Received: by wgbdm7 with SMTP id dm7so31293494wgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 12:59:07 -0700 (PDT)
Message-ID: <551AFC7E.8090108@gmail.com>
Date: Tue, 31 Mar 2015 21:58:54 +0200
From: =?UTF-8?B?RmlsaXAgQnJvem92acSH?= <fbrozovic@gmail.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/83xx: add support for mpc8306
References: <1427561968-32049-1-git-send-email-fbrozovic@gmail.com>
 <1427824493.22867.226.camel@freescale.com>
In-Reply-To: <1427824493.22867.226.camel@freescale.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/31/2015 7:54 PM, Scott Wood wrote:
> This breaks multiplatform support.  You need to determine this at
> runtime.

Understood, but I'm unsure of how to do this exactly. Would it be 
appropriate to define another array, snum_init_14, with the SNUM values 
for the MPC8306 QE, change the minimum number of SNUMs in 
qe_get_num_of_snums() to 14 and set the correct values this way? In that 
case, compatibility with other platforms would be kept intact, and the 
QE device tree node for MPC8306 (and MPC8309) boards would just have to 
have the fsl,qe-num-snums property set to 14 in order for the driver to 
set the correct values.
