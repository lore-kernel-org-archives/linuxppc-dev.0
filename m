Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9G5g1FyrzDqpR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 04:00:38 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BHx5fe106241
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 14:00:37 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9ung2r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 14:00:36 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 15:00:33 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 95AAF1DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 14:00:21 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BI0U6718350460
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 15:00:30 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BI0Ukb000695
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 15:00:30 -0300
Subject: Re: [PATCH v3] powerpc/pseries: use pci_host_bridge.release_fn() to
 kfree(phb)
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1470865522-28046-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20160811064036.GB3787@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, andrew.donnellan@au1.ibm.com
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Thu, 11 Aug 2016 15:00:26 -0300
MIME-Version: 1.0
In-Reply-To: <20160811064036.GB3787@gwshan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <2940b413-9167-3d08-b8e3-6fa8b0f7b228@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Gavin,

tl;dr: thanks for the comments & suggestions; i'll submit v4.

On 08/11/2016 03:40 AM, Gavin Shan wrote: [added some line breaks]
> It seems the user has two options here:

> (1) Setup bridge's release_fn() and call
> pcibios_free_controller() explicitly;

I think the v3 design was non-intuitive in that point -- it does not
seem right for an user to use both options:

if release_fn() is set and is called before pcibios_free_controller()
(normal case w/ DLPAR/PCI hotplug/cxl, as buses/devices are supposed
to be removed before the controller is released) the latter will use
an invalid 'phb' pointer. (what Andrew reported)

In that scenario, it's not even possible for pcibios_free_controller()
to try to detect if release_fn() was already run or not, as the only
information it has is the 'phb' pointer, which may be invalid.

So, I believe the elegant way out of this is your suggestion to have
"immediate or deferred release" and make the user *choose* either one.

Obviously, let's make this explicit to the user -- w/ rename & comments.

 > (2) Call pcibios_free_controller() without
> a valid bridge's release_fn() initialized.

Ok, that looks legitimate for those using immediate release (default).

i.e., once an user decides to use deferred released, it's understood
that pcibios_free_controller() should not be called.

 > I think we can provide better interface
> to users: what we do in pcibios_free_controller() and pcibios_host_bridge_release()
> should be (almost) same. pcibios_host_bridge_release() can be a wrapper of
> pcibios_free_controller().

Right; I implemented only kfree() in pcibios_host_bridge_release()
because I was focused on when it runs *after* pcibios_free_controller();
but it turns out that if it runs *before*, phb becomes invalid pointer.

So, you're right -- both functions are expected to have the same effect
(slightly different code), that is all of what pcibios_free_controller()
does.  The only difference should be the timing. (good point on wrapper)

 > With this, the users have two options: (1) Rely on bridge's
> release_fn() to free the PCI controller; (2) Call pcibios_free_controller() as we're
> doing currently. Those two options corresponds to immediately or deferred releasing.

Looks very good.  I'll submit a v4 like this:
-rename pcibios_host_bridge_release()/pcibios_free_controller_deferred()
-add comments about using _either_ one or another
-pcibios_free_controller_deferred() calls pcibios_free_controller().

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
