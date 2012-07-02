Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A9BB52C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 07:32:00 +1000 (EST)
Message-ID: <4FF21343.20408@freescale.com>
Date: Mon, 2 Jul 2012 16:31:47 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] PPC: use CURRENT_THREAD_INFO instead of open coded
 assembly
References: <1341262574-2841-1-git-send-email-stuart.yoder@freescale.com>
 <40388C8A-6D3B-409E-9C6D-45005E1F6016@suse.de>
 <1341264368.2588.49.camel@pasglop>
 <DAF1D512-B0CF-497D-8626-1C75103C6EA0@suse.de>
In-Reply-To: <DAF1D512-B0CF-497D-8626-1C75103C6EA0@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2012 04:27 PM, Alexander Graf wrote:
> 
> On 02.07.2012, at 23:26, Benjamin Herrenschmidt wrote:
> 
>> On Mon, 2012-07-02 at 22:59 +0200, Alexander Graf wrote:
>>> This should go into an #ifdef __ASSEMBLY__ block, right? :)
>> 
>> We almost never use #ifdef __ASSEMBLY__, we use it the other way
>> around, to prevent C stuff from being included in assembly. The
>> other way around is legit since things might be used in inline asm
>> for example.
> 
> I'm not sure I want to see this bit of code used as is in inline asm
> :). I don't even think it's possible, since it's a full statement.
> Either way, it's safer with the guard.

Safer from what?  It won't be expanded unless referenced.  How is this
better than putting ifdefs on #includes, prototypes, struct definitions,
etc.?  The ifdef is just clutter.

-Scott
