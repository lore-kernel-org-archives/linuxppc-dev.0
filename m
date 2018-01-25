Return-Path: <frowand.list@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRt0035jBzDqvh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 17:48:00 +1100 (AEDT)
Received: by mail-io0-x242.google.com with SMTP id 25so7523539ioj.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 22:48:00 -0800 (PST)
Subject: Re: [RFC PATCH v2 0/1] of: easier debugging for node life cycle issues
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 devicetree@vger.kernel.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-renesas-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org
References: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
 <ac4f02e1-6d49-158a-4fb6-56ac0d474a44@gmail.com>
 <20180122114948.mm5mg6zqw3hmjj4o@katana>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <11cf8fac-d2fe-ecdb-546f-de3c3b42a637@gmail.com>
Date: Wed, 24 Jan 2018 22:47:55 -0800
MIME-Version: 1.0
In-Reply-To: <20180122114948.mm5mg6zqw3hmjj4o@katana>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/22/18 03:49, Wolfram Sang wrote:
> Hi Frank,
> 
>> Please go back and read the thread for version 1.  Simply resubmitting a
>> forward port is ignoring that whole conversation.
>>
>> There is a lot of good info in that thread.  I certainly learned stuff in it.
> 
> Yes, I did that and learned stuff, too. My summary of the discussion was:
> 
> - you mentioned some drawbacks you saw (like the mixture of trace output
>   and printk output)> - most of them look like addressed to me? (e.g. Steven showed a way to redirect
>   printk to trace
> - you posted your version (which was, however, marked as "not user friendly"
>   even by yourself)

Not exactly a fair quoting.  There were two things I said:

  "Here is a patch that I have used.  It is not as user friendly in terms
  of human readable stack traces (though a very small user space program
  should be able to fix that)."

     So easy to fix using existing userspace programs to convert kernel
     addresses to symbols.

  "FIXME: Currently using pr_err() so I don't need to set loglevel on boot.

          So obviously not a user friendly tool!!!
          The process is:
             - apply patch
             - configure, build, boot kernel
             - analyze data
             - remove patch"

     So not friendly because it uses pr_err() instead of pr_debug().  In
     a reply I said if I submitted my patches I would change it to use
     pr_debug() instead.  So not an issue.

     And not user friendly because it requires patching the kernel.
     Again a NOP if I submitted my patch, because the patch would
     already be in the kernel.

But whatever, let's ignore that - a poor quoting is not a reason to
reject this version of the patch.


> - The discussion stalled over having two approaches

Then you should have stated such when you resubmitted.


> So, I thought reposting would be a good way of finding out if your
> concerns were addressed in the discussion or not. If I overlooked

Then you should have stated that there were concerns raised in the
discussion and asked me if my concerns were addressed.


> something, I am sorry for that. Still, my intention is to continue the
> discussion, not to ignore it. Because as it stands, we don't have such a
> debugging mechanism in place currently, and with people working with DT
> overlays, I'd think it would be nice to have.
> 
> Kind regards,
> 
>    Wolfram
> 


Rob suggested:

     >
     > @@ -25,8 +28,10 @@
     >   */
     >  struct device_node *of_node_get(struct device_node *node)
     >  {
     > -       if (node)
     > +       if (node) {
     >                 kobject_get(&node->kobj);
     > +               trace_of_node_get(refcount_read(&node->kobj.kref.refcount), node->full_name);

     Seems like there should be a kobj wrapper to read the refcount.

As far as I noticed, that was never addressed.  I don't know the answer, but
the question was asked.  And if there is no such function, then there is at
least kref_read(), which would improve the code a little bit.

I'll reply to the patch 0/1 and patch 1/1 emails with review comments.

-Frank
