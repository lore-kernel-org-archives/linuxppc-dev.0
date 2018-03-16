Return-Path: <dan.carpenter@oracle.com>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402pqZ5VKVzDr2S
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 02:12:58 +1100 (AEDT)
Date: Fri, 16 Mar 2018 13:35:11 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>,
 Josh Sklar <sklar@linux.vnet.ibm.com>,
 Kees Cook <keescook@chromium.org>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] powerpc: Use common error handling code in setup_new_fdt()
Message-ID: <20180316103511.77hog6scdxg2k7ts@mwanda>
References: <0dd9d938-8d89-f0e0-f05f-9a3e5dc42a57@users.sourceforge.net>
 <87fu52jqtc.fsf@morokweng.localdomain>
 <20180315115753.rjejlkrp3fhdxbyk@mwanda>
 <87bmfofh8y.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87bmfofh8y.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 16, 2018 at 09:26:53PM +1100, Michael Ellerman wrote:
> Dan Carpenter <dan.carpenter@oracle.com> writes:
> > On Wed, Mar 14, 2018 at 06:22:07PM -0300, Thiago Jung Bauermann wrote:
> >> SF Markus Elfring <elfring@users.sourceforge.net> writes:
> >> > From: Markus Elfring <elfring@users.sourceforge.net>
> >> > Date: Sun, 11 Mar 2018 09:03:42 +0100
> >> >
> >> > Add a jump target so that a bit of exception handling can be better reused
> >> > at the end of this function.
> >> >
> >> > This issue was detected by using the Coccinelle software.
> >> >
> >> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> >> > ---
> >> >  arch/powerpc/kernel/machine_kexec_file_64.c | 28 ++++++++++++----------------
> >> >  1 file changed, 12 insertions(+), 16 deletions(-)
> >> 
> >> I liked it. Thanks!
> >> 
> >> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> >
> > You know that compilers already re-use string constants so this doesn't
> > actually save memory?
> 
> Sure, but it's still clearer to only have the string appear once in the
> code.
> 

To me the original was better.

> > Also we should be preserving the error codes
> > instead of always returning -EINVAL.
> 
> The error codes come from libfdt code, so they don't necessarily make
> sense in the kernel. eg. FDT_ERR_NOSPACE == 3 == ESRCH.
> 
> Perhaps we should be trying harder to convert them, but that's a
> criticism of the original code not this patch.

Ah.  You're right.  I look at the patch in context, sorry.

regards,
dan carpenter
