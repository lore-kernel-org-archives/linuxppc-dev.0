Message-Id: <199905232019.PAA10710@lists.linuxppc.org>
Date: Sun, 23 May 1999 22:19:09 +0200 (CEST)
From: laures@esiea.fr
Subject: Good news for the Initio Miles owners
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I managed to get the ini9100UW somehow to work.
My system is a 8600/250 with an SCSI and an Ultra SCSI disks on the PCI
card.

I can partition, format, copy/erase stuff -> no problem so far, although
I'll do some deeper tests (any advice on extensive tests, benchmarking
etc ?)

I'm releasing here the (trivial) patch for those who wants to test it as
well (UW disks would be cool).

--- linux-2.2.6/drivers/scsi/i91uscsi.h	Sun May 23 00:14:06 1999
+++ linux/drivers/scsi/i91uscsi.h	Sun May 23 18:22:34 1999
@@ -649,7 +649,7 @@
 	UCHAR NVM_TargFConfig;	/* 1Fh -> Target F configuration */
 } NVRAM_SCSI;
 
-typedef struct _NVRAM {
+typedef struct _ini_NVRAM {
 /*----------header ---------------*/
 	USHORT NVM_Signature;	/* 0,1: Signature */
 	UCHAR NVM_Size;		/* 2:   Size of data structure */
@@ -667,7 +667,7 @@
 	UCHAR NVM_reserved[10];
 	/* ---------- CheckSum ----------       */
 	USHORT NVM_CheckSum;	/* 0x3E, 0x3F: Checksum of NVRam        */
-} NVRAM, *PNVRAM;
+} ini_NVRAM, *PNVRAM;
 
 /* Bios Configuration for nvram->BIOSConfig1                            */
 #define NBC1_ENABLE             0x01	/* BIOS enable                  */
--- linux-2.2.6/drivers/scsi/i91uscsi.c	Sun May 23 00:14:06 1999
+++ linux/drivers/scsi/i91uscsi.c	Sun May 23 18:22:34 1999
@@ -156,8 +156,8 @@
 static INI_ADPT_STRUCT i91u_adpt[MAX_SUPPORTED_ADAPTERS];
 
 /*NVRAM nvram, *nvramp = &nvram; */
-static NVRAM i91unvram;
-static NVRAM *i91unvramp;
+static ini_NVRAM i91unvram;
+static ini_NVRAM *i91unvramp;
 
 
My advice is to keep it as a module, and then do as root "insmod
/lib/module/2.2.6/scsi/initio.o".
If not, the order of the HDs will change (sda, sdb etc...) and the
system may not boot at all.

Give me feedback !


-- 
Guillaume Laurès - student @ ESIEA (www.esiea.fr)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
