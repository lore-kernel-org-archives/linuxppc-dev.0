Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-ie0-x230.google.com (mail-ie0-x230.google.com
 [IPv6:2607:f8b0:4001:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 569D72C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 04:57:02 +1100 (EST)
Received: by mail-ie0-f176.google.com with SMTP id x14so9044719ief.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 10:56:58 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <1364319962-30967-3-git-send-email-cody@linux.vnet.ibm.com>
References: <1364319962-30967-1-git-send-email-cody@linux.vnet.ibm.com>
 <1364319962-30967-3-git-send-email-cody@linux.vnet.ibm.com>
Date: Tue, 26 Mar 2013 10:56:58 -0700
Message-ID: <CAE9FiQVSPdCqaLKapG4DJ1CXtPKb8F29=s_-e9OLpXP7yG1XTA@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/mm/numa: use setup_nr_node_ids() instead of
 opencoding.
From: Yinghai Lu <yinghai@kernel.org>
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 26, 2013 at 10:46 AM, Cody P Schafer
<cody@linux.vnet.ibm.com> wrote:
> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> ---
>  arch/x86/mm/numa.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 72fe01e..a71c4e2 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -114,14 +114,11 @@ void numa_clear_node(int cpu)
>   */
>  void __init setup_node_to_cpumask_map(void)
>  {
> -       unsigned int node, num = 0;
> +       unsigned int node;
>
>         /* setup nr_node_ids if not done yet */
> -       if (nr_node_ids == MAX_NUMNODES) {
> -               for_each_node_mask(node, node_possible_map)
> -                       num = node;
> -               nr_node_ids = num + 1;
> -       }
> +       if (nr_node_ids == MAX_NUMNODES)
> +               setup_nr_node_ids();

For 1 and 2,

Acked-by: Yinghai Lu <yinghai@kernel.org>
