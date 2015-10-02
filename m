Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f176.google.com (mail-yk0-f176.google.com
 [209.85.160.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27D091A0035
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 07:37:38 +1000 (AEST)
Received: by ykdz138 with SMTP id z138so123117462ykd.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2015 14:37:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1443816930.13186.214.camel@otta>
References: <560EA623.1040300@redhat.com>
 <CAOJe8K1gQFRakYVWPYe0j9+Zc+s9hqB7uFF_aZh9NwCZSfTB_w@mail.gmail.com>
 <1443816930.13186.214.camel@otta>
Date: Sat, 3 Oct 2015 00:37:35 +0300
Message-ID: <CAOJe8K2GOsBk=CcWaZqq9KN=McLad97BP6ZhEdRB7i2Ag4csOg@mail.gmail.com>
Subject: Re: Missing operand for tlbie instruction on Power7
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Peter Bergner <bergner@vnet.ibm.com>
Cc: Laura Abbott <labbott@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a11490c18d699af052125f884
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11490c18d699af052125f884
Content-Type: text/plain; charset=UTF-8

On 10/2/15, Peter Bergner <bergner@vnet.ibm.com> wrote:
> On Fri, 2015-10-02 at 22:03 +0300, Denis Kirjanov wrote:
>> arch/powerpc/kernel/swsusp_asm64.S: Assembler messages:
>>> arch/powerpc/kernel/swsusp_asm64.S:188: Error: missing operand
>>> scripts/Makefile.build:294: recipe for target
>>> 'arch/powerpc/kernel/swsusp_asm64.o' failed
>>> make[1]: *** [arch/powerpc/kernel/swsusp_asm64.o] Error 1
>>> Makefile:941: recipe for target 'arch/powerpc/kernel' failed
>>> make: *** [arch/powerpc/kernel] Error 2
> [snip]
>>> I don't know enough ppc assembly to properly fix this but I can test.
>>
>> Could you please test the patch attached?
> [snip]
>> -0:     tlbie   r4;                             \
>> +0:     tlbie   r4, 0;                          \
>
> This isn't correct.  With POWER7 and later (which this compile
> is, since it's on LE), the tlbie instruction takes two register
> operands:
>
>     tlbie RB, RS
>
> The tlbie instruction on pre POWER7 cpus had one required register
> operand (RB) and an optional second L operand, where if you omitted
> it, it was the same as using "0":
>
>     tlbie RB, L
>
> This is a POWER7 and later build, so your change which adds the "0"
> above is really adding r0 for RS.  The new tlbie instruction doesn't
> treat r0 specially, so you'll be using whatever random bits which
> happen to be in r0 which I don't think that is what you want.

Ok, than we can just zero out r5 for example and use it in tlbie as RS,
right?


>
>
> Peter
>
>
>
>

--001a11490c18d699af052125f884
Content-Type: text/x-patch; charset=US-ASCII; name="tlbie_fix2.patch"
Content-Disposition: attachment; filename="tlbie_fix2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

ZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wcGNfYXNtLmggYi9hcmNoL3Bv
d2VycGMvaW5jbHVkZS9hc20vcHBjX2FzbS5oCmluZGV4IGRkMGZjMTguLmNiMGY2MjcgMTAwNjQ0
Ci0tLSBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wcGNfYXNtLmgKKysrIGIvYXJjaC9wb3dl
cnBjL2luY2x1ZGUvYXNtL3BwY19hc20uaApAQCAtNDQzLDkgKzQ0MywxMCBAQCBFTkRfRlRSX1NF
Q1RJT05fTkVTVEVEKENQVV9GVFJfSEFTX1BQUixDUFVfRlRSX0hBU19QUFIsOTQ1KQogI2lmICFk
ZWZpbmVkKENPTkZJR180eHgpICYmICFkZWZpbmVkKENPTkZJR184eHgpCiAjZGVmaW5lIHRsYmlh
CQkJCQlcCiAJbGkJcjQsMTAyNDsJCQlcCisJbGkgIHI1LDA7CQkJCVwKIAltdGN0cglyNDsJCQkJ
XAogCWxpcwlyNCxLRVJORUxCQVNFQGg7CQlcCi0wOgl0bGJpZQlyNDsJCQkJXAorMDoJdGxiaWUJ
cjQsIHI1OwkJCQlcCiAJYWRkaQlyNCxyNCwweDEwMDA7CQkJXAogCWJkbnoJMGIKICNlbmRpZgo=
--001a11490c18d699af052125f884--
