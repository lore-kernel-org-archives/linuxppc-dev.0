Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id A4CCDDDE3A
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 05:01:05 +1100 (EST)
Message-ID: <45D9E5D9.6060704@smiths-aerospace.com>
Date: Mon, 19 Feb 2007 13:00:57 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 0/2] libfdt: problems with real life blobs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David,

I've been trying to use your libfdt in u-boot and my first step, get a 
value from the blob, failed terminally.  After poking about a bit, it 
appears that your libfdt and Jon Loeliger's dtc (-V 16) disagree with 
respect to the format of the blob - libfdt won't traverse the path.

I've created two patches:
1) Make the libfdt tests use "fdt endian" so that dtc can be used.
2) Create a minimal test tree and compile it with dtc.

The first patch is clean, the second patch is a bit of a hack job, I did 
just enough to check this out and confirm/deny my suspicions that libfdt 
doesn't like the dtc format.  Running the tests on the dtc-compiled blob 
shows the same problems with traversing paths.

I think I created the correct tree in test_tree1.dts (I didn't do the 
truncated node, but that is immaterial for my primary objective) but I 
could be wrong...

Supporting using dtc in the long run as well as the assembly-generated 
blob would be nice so that regression tests can be done on different 
versions of the blob format (both supported and unsupported) and to make 
sure libfdt and dtc stay in sync.

Best regards,
gvb
