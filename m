Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A03841A0243
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jun 2014 22:41:10 +1000 (EST)
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C678D1400DD
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2014 22:41:09 +1000 (EST)
Received: by mail-wg0-f42.google.com with SMTP id z12so5073860wgg.13
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2014 05:41:06 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: OF_DYNAMIC node lifecycle
To: Nathan Fontenot <nfont@austin.ibm.com>, Tyrel Datwyler
 <tyreld@linux.vnet.ibm.com>
In-Reply-To: <53AC7C2D.3040604@austin.ibm.com>
References: <CACxGe6tsXuLZT=h8S0yRPRPy6Hqz1xkX8G+ViY0cxEUuxZ1dsw@mail.gmail.com>
 <53A30117.3010100@austin.ibm.com>
 <20140623144806.1348EC40A60@trevor.secretlab.ca>
 <53A9DB4F.9060708@austin.ibm.com>
 <20140625202446.77687C40AE6@trevor.secretlab.ca>
 <53AC7C2D.3040604@austin.ibm.com>
Date: Fri, 27 Jun 2014 13:41:01 +0100
Message-Id: <20140627124101.367F7C40E5E@trevor.secretlab.ca>
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

On Thu, 26 Jun 2014 15:01:49 -0500, Nathan Fontenot <nfont@austin.ibm.com> wrote:
> On 06/25/2014 03:24 PM, Grant Likely wrote:
> > On Tue, 24 Jun 2014 15:10:55 -0500, Nathan Fontenot <nfont@austin.ibm.com> wrote:
> >>>> heh! I have often thought about adding reference counting to device tree
> >>>> properties.
> >>>
> >>> You horrible, horrible man.
> >>
> >> Yes. I are evil :)
> >>
> >> After looking again the work needed to add reference counts to properties
> >> would be huge. The few properties I am concerned with are specific to powerpc
> >> so perhaps just adding an arch specific lock around updating those
> >> properties would work.
> > 
> > Which code/properties? I'd like to have a look myself.
> 
> /ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory
> 
> The property is updated in 
> arch/powerpc/platforms/pseries/hotplug-memory.c:pseries_update_drconf_memory()

Specifically, what do you need for the locking? Are you wanting to hold
off additional changes while that function is executing? Pantelis is
adding a mutex for device tree writers. Holding that mutex would prevent
any changes from happening in the tree without affecting readers. Would
that be sufficient?

g.
