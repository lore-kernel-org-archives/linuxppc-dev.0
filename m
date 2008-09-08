Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C80C2DDFC0
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 07:27:20 +1000 (EST)
Date: Tue, 9 Sep 2008 01:27:17 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: git apply vs. renamed files index mismatch (was: Re: [PATCH 1/4]
	POWERPC: Rename dma_64.c to dma.c)
Message-ID: <20080908212717.GA21338@oksana.dev.rtsoft.ru>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<48C57A92.6060608@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48C57A92.6060608@freescale.com>
Cc: git@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 08, 2008 at 02:18:42PM -0500, Scott Wood wrote:
> Becky Bruce wrote:
>> This is in preparation for the merge of the 32 and 64-bit
>> dma code in arch/powerpc.
>>
>> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
>> ---
>>  arch/powerpc/kernel/Makefile |    2 +-
>>  arch/powerpc/kernel/dma.c    |  200 ++++++++++++++++++++++++++++++++++++++++++
>>  arch/powerpc/kernel/dma_64.c |  200 ------------------------------------------
>>  3 files changed, 201 insertions(+), 201 deletions(-)
>>  create mode 100644 arch/powerpc/kernel/dma.c
>>  delete mode 100644 arch/powerpc/kernel/dma_64.c
>
> Passing -M to git format-patch makes it much easier

I always thought that posting "-M" patches to the public lists is
discouraged since it is quite difficult to apply them via patch(1).
Also think of non-git users...

> to see whether  
> anything changed between the old file and the new file.

This is still possible by comparing the hashes:

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
new file mode 100644
index 0000000..ae5708e
[...]
diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
deleted file mode 100644
index ae5708e..0000000

That is, if hashes match then it was pure rename.

Though, too bad git {apply,am} does not produce any warnings if there
are any hidden changes...

Cc'ing git mailing list.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
