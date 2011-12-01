Return-Path: <glikely@secretlab.ca>
Received: from mail-qw0-f49.google.com (mail-qw0-f49.google.com
 [209.85.216.49]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 95132B6F69
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 08:55:49 +1100 (EST)
Received: by qabj40 with SMTP id j40so1942076qab.15
 for <linuxppc-dev@ozlabs.org>; Thu, 01 Dec 2011 13:55:46 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4ED7F72F.7050405@freescale.com>
References: <1322760781-31226-1-git-send-email-timur@freescale.com>
 <4ED7CA64.2080503@freescale.com> <4ED7E975.6090704@freescale.com>
 <4ED7F1AE.70806@freescale.com> <4ED7F5AA.2040909@freescale.com>
 <4ED7F72F.7050405@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 1 Dec 2011 14:55:22 -0700
Message-ID: <CACxGe6sZgG5q6NKgsGaWLyTzWHXNGqHke9nQMyqzw0audS3=tw@mail.gmail.com>
Subject: Re: [PATCH] i2c-mpc: use the cell-index property to enumerate the I2C
 adapters
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
 Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 1, 2011 at 2:52 PM, Scott Wood <scottwood@freescale.com> wrote:
> On 12/01/2011 03:46 PM, Timur Tabi wrote:
>> Scott Wood wrote:
>>
>>> How is this going to interact with other i2c buses (e.g. on a board
>>> FPGA) that might have a conflicting static numbering scheme? =A0Have yo=
u
>>> ensured that no dynamic bus registrations (e.g. an i2c bus on a PCI
>>> device) can happen before the static SoC i2c buses are added?
>>
>> Hmm.... You have a point there.
>>
>>>> An alternative approach is to create a function like this:
>>>>
>>>> =A0 =A0 struct i2c_adapter *i2c_adapter_from_node(struct device_node *=
np);
>>>>
>>>> I could then just use adap->nr directly.
>>>
>>> If there isn't a way to get a "struct device" from "struct device_node"=
,
>>> we should add it.
>>
>> How do I do that? =A0Scan all the struct devices until I find one where =
dev->of_node =3D=3D np? =A0That seems really inefficient.
>
> Ideally we would have a field in struct device_node that points to
> struct device.

No.  There are cases where multiple devices may reference the same node.

It is better to walk the list of i2c adapters and look for one that
has the matching node pointer.  It really isn't an expensive operation
to do it that way.

g.
