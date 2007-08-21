Return-Path: <scottwood@freescale.com>
Message-ID: <46CB10DD.4090005@freescale.com>
Date: Tue, 21 Aug 2007 11:20:45 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 14/20] bootwrapper: Add strtoull().
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820174004.GM30562@ld0162-tx32.am.freescale.net>
	<20070821024713.GM15469@localhost.localdomain>
In-Reply-To: <20070821024713.GM15469@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
>>+/* Not currently supported: leading whitespace, sign, 0x prefix, zero base */
>>+unsigned long long int strtoull(const char *ptr, char **end, int base)
>>+{
>>+	unsigned long long ret = 0;
>>+
>>+	while (*ptr) {
>>+		int digit;
>>+
>>+		if (*ptr >= '0' && *ptr <= '9')
>>+			digit = *ptr - '0';
>>+		else if (*ptr >= 'A' && *ptr <= 'Z')
>>+			digit = *ptr - 'A' + 10;
>>+		else if (*ptr >= 'a' && *ptr <= 'z')
>>+			digit = *ptr - 'a' + 10;
>>+		else
>>+			break;
> 
> 
> Hrm... I note this has no sort of error checking if the string has
> digits which don't fit in the given base.

Oops.  I'll fix that.

-Scott
