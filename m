Return-Path: <christophe.jaillet@wanadoo.fr>
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr
 [80.12.242.124])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAE681A08A6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 17:20:17 +1100 (AEDT)
Subject: Re: [PATCH v2] powerpc/mpc5xxx: Avoid dereferencing potentially freed
 memory
To: Michael Ellerman <mpe@ellerman.id.au>
References: <20151014040011.8AB1514110A@ozlabs.org>
 <1444888580-12966-1-git-send-email-christophe.jaillet@wanadoo.fr>
 <1444890977.5970.4.camel@ellerman.id.au>
Cc: benh@kernel.crashing.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <5620971D.8040103@wanadoo.fr>
Date: Fri, 16 Oct 2015 08:20:13 +0200
MIME-Version: 1.0
In-Reply-To: <1444890977.5970.4.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 15/10/2015 08:36, Michael Ellerman a écrit :
> On Thu, 2015-10-15 at 07:56 +0200, Christophe JAILLET wrote:
>> Use 'of_property_read_u32()' instead of 'of_get_property()'+pointer
>> dereference in order to avoid access to potentially freed memory.
>>
>> Use 'of_get_next_parent()' to simplify the while() loop and avoid the
>> need of a temp variable.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> v2: Use of_property_read_u32 instead of of_get_property+pointer dereference
>> *** Untested ***
> Thanks.
>
> Can someone with an mpc5xxx test this?
>
> cheers
>

Hi,
I don't think it is an issue, but while looking at another similar 
patch, I noticed that the proposed patch adds a call to be32_to_cpup() 
(within of_property_read_u32).
Apparently, powerPC is a BE architecture, so this call should be a no-op.

Just wanted to point it out, in case of.

Best regards,
CJ
