Return-Path: <akinobu.mita@gmail.com>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA6EEB70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Feb 2011 14:08:22 +1100 (EST)
Received: by qyk34 with SMTP id 34so1065225qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 06 Feb 2011 19:08:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1297034086.14982.8.camel@pasglop>
References: <1296136583-13815-1-git-send-email-akinobu.mita@gmail.com>
	<1296136583-13815-3-git-send-email-akinobu.mita@gmail.com>
	<1297034086.14982.8.camel@pasglop>
Date: Mon, 7 Feb 2011 12:08:18 +0900
Message-ID: <AANLkTik3OEJV1AMSDPg+DkmxZuGL7uzBHSswRorhc7xQ@mail.gmail.com>
Subject: Re: [PATCH -mm 2/6] powerpc: convert little-endian bitops macros to
	static inline functions
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	akpm@linux-foundation.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2011/2/7 Benjamin Herrenschmidt <benh@kernel.crashing.org>:
> On Thu, 2011-01-27 at 22:56 +0900, Akinobu Mita wrote:
>> (This patch is intended to be folded into the patch in -mm:
>> powerpc-introduce-little-endian-bitops.patch)
>>
>> The little-endian bitops on powerpc are written as preprocessor
>> macros with the cast to "unsigned long *".
>> This means that even non-pointers will be accepted without an error, and
>> that is a Very Bad Thing.
>>
>> This converts the little-endian bitops macros to static inline functions
>> with proper prototypes.
>
> No objection to the powerpc variant of the patches. What is the status
> with the wholes series tho ? Does it looks like its going to be
> accepted ? Do you expect my Ack and will merge the whole thing at once ?

The whole series now seems acceptable since I fixed two issues
that Linus found annoying. (the naming and the change of prototype)

Please give your ack if it is OK.

I should have fixed them quickly so that the series went upstream
in the last merge windows. But I couldn't because I spent some time
fixing and compile testing for a bisection hole.

> Does it break bisection unless it's merged as one single giant patch ?

I think there is no known problem that breaks bisectability by
this patch series.
