Return-Path: <pshelar@nicira.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A24A21A1A29
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 04:30:00 +1000 (AEST)
Received: by wibxm9 with SMTP id xm9so130650609wib.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 11:29:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1437500193-10255-1-git-send-email-chris.j.arges@canonical.com>
References: <20150721162418.GM38815@linux.vnet.ibm.com>
 <1437500193-10255-1-git-send-email-chris.j.arges@canonical.com>
Date: Tue, 21 Jul 2015 11:29:56 -0700
Message-ID: <CALnjE+rBtWhiGdjEi4cANpuu54muv9DtO=q_37eZ70Ou2FuDFw@mail.gmail.com>
Subject: Re: [PATCH v2] openvswitch: allocate nr_node_ids flow_stats instead
 of num_possible_nodes
From: Pravin Shelar <pshelar@nicira.com>
To: Chris J Arges <chris.j.arges@canonical.com>
Cc: nacc@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, linux-numa@vger.kernel.org,
 David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
 "dev@openvswitch.org" <dev@openvswitch.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 21, 2015 at 10:36 AM, Chris J Arges
<chris.j.arges@canonical.com> wrote:
> Some architectures like POWER can have a NUMA node_possible_map that
> contains sparse entries. This causes memory corruption with openvswitch
> since it allocates flow_cache with a multiple of num_possible_nodes() and
> assumes the node variable returned by for_each_node will index into
> flow->stats[node].
>
> Use nr_node_ids to allocate a maximal sparse array instead of
> num_possible_nodes().
>
> The crash was noticed after 3af229f2 was applied as it changed the
> node_possible_map to match node_online_map on boot.
> Fixes: 3af229f2071f5b5cb31664be6109561fbe19c861
>
> Signed-off-by: Chris J Arges <chris.j.arges@canonical.com>

Acked-by: Pravin B Shelar <pshelar@nicira.com>

Thanks.
