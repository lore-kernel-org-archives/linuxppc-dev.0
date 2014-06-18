Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 599D51A02C0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 06:07:50 +1000 (EST)
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com
 [209.85.223.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A654A140087
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2014 06:07:48 +1000 (EST)
Received: by mail-ie0-f181.google.com with SMTP id y20so1133588ier.26
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2014 13:07:46 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@linaro.org>
Date: Wed, 18 Jun 2014 21:07:26 +0100
Message-ID: <CACxGe6tsXuLZT=h8S0yRPRPy6Hqz1xkX8G+ViY0cxEUuxZ1dsw@mail.gmail.com>
Subject: OF_DYNAMIC node lifecycle
To: Nathan Fontenot <nfont@austin.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nathan and Tyrel,

I'm looking into lifecycle issues on nodes modified by OF_DYNAMIC, and
I'm hoping you can help me. Right now, pseries seems to be the only
user of OF_DYNAMIC, but making OF_DYNAMIC work has a huge impact on
the entire kernel because it requires all DT code to manage reference
counting with iterating over nodes. Most users simply get it wrong.
Pantelis did some investigation and found that the reference counts on
a running kernel are all over the place. I have my doubts that any
code really gets it right.

The problem is that users need to know when it is appropriate to call
of_node_get()/of_node_put(). All list traversals that exit early need
an extra call to of_node_put(), and code that is searching for a node
in the tree and holding a reference to it needs to call of_node_get().

I've got a few pseries questions:
- What are the changes being requested by pseries firmware? Is it only
CPUs and memory nodes, or does it manipulate things all over the tree?
- How frequent are the changes? How many changes would be likely over
the runtime of the system?
- Are you able to verify that removed nodes are actually able to be
freed correctly? Do you have any testcases for node removal?

I'm thinking very seriously about changing the locking semantics of DT
code entirely so that most users never have to worry about
of_node_get/put at all. If the DT code is switched to use rcu
primitives for tree iteration (which also means making DT code use
list_head, something I'm already investigating), then instead of
trying to figure out of_node_get/put rules, callers could use
rcu_read_lock()/rcu_read_unlock() to protect the region that is
searching over nodes, and only call of_node_get() if the node pointer
is needed outside the rcu read-side lock.

I'd really like to be rid of the node reference counting entirely, but
I can't figure out a way of doing that safely, so I'd settle for
making it a lot easier to get correct.

Thoughts?

g.
