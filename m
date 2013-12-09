Return-Path: <kernelfans@gmail.com>
Received: from mail-qe0-x22f.google.com (mail-qe0-x22f.google.com
 [IPv6:2607:f8b0:400d:c02::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8B2462C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Dec 2013 17:17:48 +1100 (EST)
Received: by mail-qe0-f47.google.com with SMTP id t7so2534657qeb.34
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Dec 2013 22:17:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1386549112.5159.4.camel@pasglop>
References: <1386140348-7854-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1386140348-7854-2-git-send-email-pingfank@linux.vnet.ibm.com>
 <87a9gfva9n.fsf@linux.vnet.ibm.com>
 <1386549112.5159.4.camel@pasglop>
Date: Mon, 9 Dec 2013 14:17:45 +0800
Message-ID: <CAFgQCTtJh1-2wuLueREbA6ru5cje4EcxN5yT+cU-YNSrZi9O=Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc: mm: make _PAGE_NUMA take effect
From: Liu ping fan <kernelfans@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 9, 2013 at 8:31 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2013-12-05 at 16:23 +0530, Aneesh Kumar K.V wrote:
>> Liu Ping Fan <kernelfans@gmail.com> writes:
>>
>> > To enable the do_numa_page(), we should not fix _PAGE_NUMA in
>> > hash_page(), so bail out for the case of pte_numa().
>
> For some reason I don't have 2/3 and 3/3 in my mbox (though I do have
> them on patchwork) so I'll reply to this one.
>
> Overall, your statement that this is a faster path needs to be backed up
> with numbers.
>
> The code is complicated enough as it-is, such additional mess in the low
> level hashing code requires a good justification, and also a
> demonstration that it doesn't add overhead to the normal hash path.
>
For the test, is it ok to have an user application to copy page where
all page are PG_mlocked?

Thanks and regards,
Pingfan
