Return-Path: <pantelis.antoniou@konsulko.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DB2A1A0012
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jun 2014 22:40:25 +1000 (EST)
Received: from mail-we0-f180.google.com (mail-we0-f180.google.com
 [74.125.82.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CA3451400B7
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2014 22:40:24 +1000 (EST)
Received: by mail-we0-f180.google.com with SMTP id x48so5125480wes.25
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2014 05:40:21 -0700 (PDT)
Subject: Re: OF_DYNAMIC node lifecycle
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
In-Reply-To: <20140627123251.D0857C40859@trevor.secretlab.ca>
Date: Fri, 27 Jun 2014 15:40:17 +0300
Message-Id: <94595B4D-1A58-427C-B9CE-C139048FEDCD@konsulko.com>
References: <CACxGe6tsXuLZT=h8S0yRPRPy6Hqz1xkX8G+ViY0cxEUuxZ1dsw@mail.gmail.com>
 <43898B58-2EA7-42B5-A17A-27F16F2618A6@konsulko.com>
 <20140623145844.DA6A3C40AE5@trevor.secretlab.ca>
 <53A9DA69.1040101@austin.ibm.com>
 <20140625202216.16A8AC40AE6@trevor.secretlab.ca>
 <53AC7BA3.5030909@austin.ibm.com>
 <20140627123251.D0857C40859@trevor.secretlab.ca>
To: Grant Likely <grant.likely@linaro.org>
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

Hi Grant,

On Jun 27, 2014, at 3:32 PM, Grant Likely wrote:

> On Thu, 26 Jun 2014 14:59:31 -0500, Nathan Fontenot =
<nfont@austin.ibm.com> wrote:
>> On 06/25/2014 03:22 PM, Grant Likely wrote:
>>> On Tue, 24 Jun 2014 15:07:05 -0500, Nathan Fontenot =
<nfont@austin.ibm.com> wrote:
>>>> On 06/23/2014 09:58 AM, Grant Likely wrote:
>>>>> On Thu, 19 Jun 2014 11:33:20 +0300, Pantelis Antoniou =
<pantelis.antoniou@konsulko.com> wrote:
>>>>>> Hi Grant,
>>>>>>=20

[snip]

>>=20
>> This would affect property updates. When doing a property update the
>> notifier passes a pointer to a struct containing a device node
>> pointer and a pointer to the new device node property.
>>=20
>> I know specifically in memory property updates we grab the current =
version
>> of the device tree property and compare it to the 'new' version that=20=

>> was passed to us.
>>=20
>> If you want to do the DT update before calling the notifier that =
should be
>> fine for the memory update code and would only require very minimal
>> updates.
>=20
> We could change the notifier to include both the old and new values.
>=20
> I've been thinking about changing the notifier format anyway. With the
> addition of bulk changes, it would be more efficient to send a single
> notifier for all the changes with a link to the change set instead of
> one at a time.
>=20

That one has my vote. We also need a bulk change notifier, and for =
device
driver use, some kind of wrapper for specific node/properties.

At the moment a notification is fired for any change in the tree, we =
might
work something more fine-grained. Like 'watch this node & subnodes', or
'watch this property (or set of properties)'

> g.


Regards

-- Pantelis=
