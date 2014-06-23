Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D17A41A0157
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 06:28:32 +1000 (EST)
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
 [209.85.212.182])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0934214007F
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2014 06:28:31 +1000 (EST)
Received: by mail-wi0-f182.google.com with SMTP id bs8so4891795wib.15
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2014 13:28:28 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: OF_DYNAMIC node lifecycle
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
In-Reply-To: <5213060A-74FB-4CD6-BF1C-4B7DCA98BE51@konsulko.com>
References: <CACxGe6tsXuLZT=h8S0yRPRPy6Hqz1xkX8G+ViY0cxEUuxZ1dsw@mail.gmail.com>
 <43898B58-2EA7-42B5-A17A-27F16F2618A6@konsulko.com>
 <20140623145844.DA6A3C40AE5@trevor.secretlab.ca>
 <5213060A-74FB-4CD6-BF1C-4B7DCA98BE51@konsulko.com>
Date: Mon, 23 Jun 2014 21:21:35 +0100
Message-Id: <20140623202135.CC0C7C4094C@trevor.secretlab.ca>
Cc: devicetree@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 23 Jun 2014 18:26:04 +0300, Pantelis Antoniou <pantelis.antoniou@konsulko.com> wrote:
> On Jun 23, 2014, at 5:58 PM, Grant Likely wrote:
> > We'll also need a transition plan to move to RCU. I think the existing
> > iterators can be modified to do the rcu locking in-line, but still require
> > the of_node_get/put stuff (basically, so existing code continue to works
> > unchanged). Then we can add _rcu versions that drop the need for
> > of_node_get/put(). When everything is converted, the old iterators can
> > be dropped.
> > 
> 
> Eventually yes. We're not close to that yet. I'd be happy if we get the 
> lifecycle issues fixed right now (with of_node_get/put) and plan ahead.
> I am sure we missed a few things, which we will come across.

If we agree on the plan to keep of_node_get/put, but strongly reduce the
usage by switching to RCU, then I'm generally okay with proceeding with
the overlay feature because I can see how it would work in the new
model.

g.
