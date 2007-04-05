Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 9F46BDDE4A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 01:17:44 +1000 (EST)
Message-ID: <461512F3.3010704@smiths-aerospace.com>
Date: Thu, 05 Apr 2007 11:17:07 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH dtc] Implement the -R option and add a -S option.
References: <20070405020433.GA13891@dellserver.lan> <E1HZTUe-0006WY-UH@jdl.com>
In-Reply-To: <E1HZTUe-0006WY-UH@jdl.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, u-boot-users@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> So, like, the other day Jerry Van Baren mumbled:
>> Implement the -R <number> option to add memory reserve slots.
>> Add a -S <size> option makes the blob at least this number of bytes.
>>
>> Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
> 
> Applied.
> 
> Thanks,
> jdl

Thanks, Jon.  That makes the new u-boot "fdt" command tremendously 
easier to use because you can now allocate extra space in the blob at 
compile time rather than having to reallocate space using the u-boot 
"fdt" command.

Note to u-boot "fdt" command users:
* Pull the latest dtc source from Jon's repo
     <http://www.jdl.com/git_repos/>
* When you compile your dts, use the new -S parameter to create some
     extra space (e.g. -S 0x2000).  If you don't want to guess how big
     your current blob is, run a test compile with -S 1 - you will get
     a warning (don't use -q ;-) that will tell you how big your
     blob is.  Re-run with a reasonable -S.
* The -R to make extra mem reserve slots may be useful too.
* Make sure you *don't* specify version 16 (some legacy recipes do
     that).  The latest version is 17 and dtc now Does The Right Thing
     without needing the version specified.  Do *not* use -V.

Best regards,
gvb
