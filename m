Return-Path: <nfont@austin.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 378DC1A0015
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jun 2014 00:41:15 +1000 (EST)
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 63DC01400DC
 for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2014 00:41:14 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@austin.ibm.com>;
 Fri, 27 Jun 2014 08:41:11 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5C45319D8026
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2014 08:40:59 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5REe26266388094
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2014 16:40:02 +0200
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5REf77P015374
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2014 08:41:07 -0600
Message-ID: <53AD8281.8060505@austin.ibm.com>
Date: Fri, 27 Jun 2014 09:41:05 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Grant Likely <grant.likely@linaro.org>
Subject: Re: OF_DYNAMIC node lifecycle
References: <CACxGe6tsXuLZT=h8S0yRPRPy6Hqz1xkX8G+ViY0cxEUuxZ1dsw@mail.gmail.com>
 <43898B58-2EA7-42B5-A17A-27F16F2618A6@konsulko.com>
 <20140623145844.DA6A3C40AE5@trevor.secretlab.ca>
 <53A9DA69.1040101@austin.ibm.com>
 <20140625202216.16A8AC40AE6@trevor.secretlab.ca>
 <53AC7BA3.5030909@austin.ibm.com>
 <20140627123251.D0857C40859@trevor.secretlab.ca>
 <94595B4D-1A58-427C-B9CE-C139048FEDCD@konsulko.com>
In-Reply-To: <94595B4D-1A58-427C-B9CE-C139048FEDCD@konsulko.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On 06/27/2014 07:40 AM, Pantelis Antoniou wrote:
> Hi Grant,
> 
> On Jun 27, 2014, at 3:32 PM, Grant Likely wrote:
> 
>> On Thu, 26 Jun 2014 14:59:31 -0500, Nathan Fontenot <nfont@austin.ibm.com> wrote:
>>> On 06/25/2014 03:22 PM, Grant Likely wrote:
>>>> On Tue, 24 Jun 2014 15:07:05 -0500, Nathan Fontenot <nfont@austin.ibm.com> wrote:
>>>>> On 06/23/2014 09:58 AM, Grant Likely wrote:
>>>>>> On Thu, 19 Jun 2014 11:33:20 +0300, Pantelis Antoniou <pantelis.antoniou@konsulko.com> wrote:
>>>>>>> Hi Grant,
>>>>>>>
> 
> [snip]
> 
>>>
>>> This would affect property updates. When doing a property update the
>>> notifier passes a pointer to a struct containing a device node
>>> pointer and a pointer to the new device node property.
>>>
>>> I know specifically in memory property updates we grab the current version
>>> of the device tree property and compare it to the 'new' version that 
>>> was passed to us.
>>>
>>> If you want to do the DT update before calling the notifier that should be
>>> fine for the memory update code and would only require very minimal
>>> updates.
>>
>> We could change the notifier to include both the old and new values.
>>
>> I've been thinking about changing the notifier format anyway. With the
>> addition of bulk changes, it would be more efficient to send a single
>> notifier for all the changes with a link to the change set instead of
>> one at a time.
>>
> 
> That one has my vote. We also need a bulk change notifier, and for device
> driver use, some kind of wrapper for specific node/properties.
> 
> At the moment a notification is fired for any change in the tree, we might
> work something more fine-grained. Like 'watch this node & subnodes', or
> 'watch this property (or set of properties)'
> 

Both of these updates would work.

For property updates the only real requirement is that we can get to the new
and the old version of the property value.

I like the idea of being able to watch a single node/property. My experience
is that most code is only interested in updates to a single node or
property. Being able to avoid notifying everyone that has registered a
notifier for DT updates for every change would be nice.

-Nathan
-Nathan
