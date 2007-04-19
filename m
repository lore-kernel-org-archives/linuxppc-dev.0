Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id B6E4DDDEDF
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 04:49:51 +1000 (EST)
Message-ID: <4627B9C7.8010800@smiths-aerospace.com>
Date: Thu, 19 Apr 2007 14:49:43 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [U-Boot-Users] [PATCH: dtc take 2] Assemble the blob in memory
	before writing	it out.
References: <20070419015951.GA9339@dellserver.lan>
	<1177007241.14328.21.camel@ld0161-tx32>
In-Reply-To: <1177007241.14328.21.camel@ld0161-tx32>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>,
	u-boot-users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> On Wed, 2007-04-18 at 20:59, Jerry Van Baren wrote:
>> This makes padding out the blob if the user requested extra size much
>> easer.  The assembly and writing to the file is more straight forward too.
>>
>> Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
>> ---
>>
>> Hi David, Jon,
>>
>> I wasn't happy with David's suggestion on the -S handling.  I also wasn't
>> all that wild about how the blob was assembled and then written to the
>> file piecemeal with "ad-hoc" alignment padding.  I realized I could fix
>> both by assembling the blob in memory as a "struct data" and then write
>> the whole thing out in one fell swoop.
>>
>> Makes it a lot simpler and cleaner to my eyes.
>>
>> Hope y'all agree,
>> gvb
> 
> Jerry and David,
> 
> Sorry.  I've been out sick for a couple days here and am
> just now catching up.  I've read through the last week's
> worth of mail here now, so let me see if I have properly
> summarized where things stand and what's needed for the DTC:
> 
> These patches need to be applied:
> 
>     [PATCH dtc] Add -o <output file> to the usage message.
>     Sat, 14 Apr 2007 18:16:47 -0400
> 
>     [PATCH dtc take 3] Fix reserve map output for asm format.
>     Tue, 17 Apr 2007 18:14:41 -0400
> 
>     [PATCH: dtc take 2] Assemble the blob in memory before writing it out.
>     Wed, 18 Apr 2007 21:59:51 -0400
> 
> The last patch there replaces the "Improve -S handling" patches.
> But does the last patch replace or depend on the second one?
> 
> And I agree with David that last patch is a better approach.
> 
> Thanks,
> jdl

Yes, you have that right.

Patch #1 is good to go
   [PATCH dtc] Add -o <output file> to the usage message.
   Sat, 14 Apr 2007 18:16:47 -0400

Patch #2 and #3...
   [PATCH dtc take 3] Fix reserve map output for asm format.
   Tue, 17 Apr 2007 18:14:41 -0400
   [PATCH: dtc take 2] Assemble the blob in memory before writing it out.
   Wed, 18 Apr 2007 21:59:51 -0400

...you force me to make a confession.  The third patch depends on the 
second patch because I snuck in a fix to the ASM output into the third 
patch: the last two chunks fix the ASM header output - I padded the blob 
out but didn't change the size properly in the header.  In the third 
patch above, I added a label "%s_blob_abs_end" and used that to 
calculate the total blob size (including the padding) in the header:

-	fprintf(f, "\t.long\t_%s_blob_end - _%s_blob_start /* totalsize */\n",
+	fprintf(f, "\t.long\t_%s_blob_abs_end - _%s_blob_start /* totalsize */\n",

--------

AAAARGH!  Sorry, I see I left a debug statement in flattree.c around 
line 390:

@@ -383,28 +370,46 @@ void dt_to_blob(FILE *f, struct boot_info *bi, int 
version,
:
:
+fprintf(stderr, "minsize = %d, totalsize = %d, padlen = %d\n", minsize, 
be32_to_cpu(bph.totalsize), padlen);

Your option:
1) Take the last two patches as is and remove the fprintf yourself
2) I'll fix it tonight and provide a New Improved patch

Thanks,
gvb
