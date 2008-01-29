Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out1.tiscali.nl (smtp-out1.tiscali.nl [195.241.79.176])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5DE98DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 00:34:21 +1100 (EST)
Message-ID: <479F2B52.7010004@tiscali.nl>
Date: Tue, 29 Jan 2008 14:34:10 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH][ppc] logical/bitand typo in powerpc/boot/4xx.c
References: <4797C1AD.3040307@tiscali.nl> <1201129527.4988.69.camel@localhost>
	<4797D968.1030101@tiscali.nl> <20080129105531.GA651@shadowen.org>
In-Reply-To: <20080129105531.GA651@shadowen.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Joe Perches <joe@perches.com>, linuxppc-dev@ozlabs.org,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> On Wed, 2008-01-23 at 23:37 +0100, Roel Kluin wrote:
>>>> -		if (val && 0x1)
>>>> +		if (val & 0x1)

>> Joe Perches wrote:
>>> I think this pattern should be added to checkpatch
>>> +		if ($line =~ /\&\&\s*0[xX]/) {

> On Thu, Jan 24, 2008 at 01:18:48AM +0100, Roel Kluin wrote:
>> I agree but there will be false positives, i'd propose to change that to
>> +		if ($line =~ /(?:(?:\(|\&\&|\|\|)\s*0[xX]\s*(?:&&|\|\|)|
>> +				(?:\&\&|\|\|)\s*0[xX]\s*(?:\)|&&|\|\|))/) {

Andy Whitcroft wrote:
> That one doesn't even match the original example.  Seems to be missing
> some number matching.  The concept seems sound though.  Basically
> looking for numbers which are definatly adjacent to a boolean or a brace
> on both sides.

You are right. here's a version that does work. It works the same as
git-grep -E "((\(|&&|\|\|)[[:space:]]*(0[xX][0-9a-fA-F]+|[0-9]+)[[:space:]]*(&&|\|\|)|(&&|\|\|)[[:space:]]*(0[xX][0-9a-fA-F]+|[0-9]+)[[:space:]]*(\)|&&|\|\|))"

---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 579f50f..62276f7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1337,6 +1337,11 @@ sub process {
 			}
 		}
 
+# Check for bitwise tests written as boolean
+		if ($line =~ /((\(|&&|\|\|)\s*(0[xX][0-9a-fA-F]+|[0-9]+)\s*(&&|\|\|)|(&&|\|\|)\s*(0[xX][0-9a-fA-F]+|[0-9]+)\s*(\)|&&|\|\|))/) {
+			WARN("boolean test with hexadecimal, perhaps just \'&\' or \'|\'?\n" . $herecurr);
+		}
+
 # if and else should not have general statements after it
 		if ($line =~ /^.\s*(?:}\s*)?else\b(.*)/ &&
 		    $1 !~ /^\s*(?:\sif|{|\\|$)/) {
