Message-ID: <39353143.DFE4BBB8@snmc.com>
Date: Wed, 31 May 2000 10:35:32 -0500
From: Daris Nevil <Daris.Nevil@snmc.com>
MIME-Version: 1.0
To: Tom Roberts <tjroberts@lucent.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Do you have your minimum ramdisk image which can provide basic
 network services ?
References: <020e01bfc93f$5dc075c0$db52df8d@helsinki> <3934086C.87BF893@lucent.com> <39340AC7.689BFF86@snmc.com> <39351781.B4B61265@lucent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom,

I'm not sure what the Resolver Error 0 zero is either. I don't
remember seeing that one.

However, I do know that you don't need inetd for ping.  If you
want to use ping the way it is then you will need the nss
libraries in addition to your /etc/protocols file.  I cheated and
hacked ping.c and hard-coded the icmp protocol number.  The
patch for the hack is included below.

Daris Nevil
SiSIC Inc/SNMC

----------------------------------------------


Patch for ping.c that removes the need for /etc/protocols and nss
libraries.
By Daris Nevil (dnevil@snmc.com)
To patch:
        cd netkit-base-0.10/ping
        patch -Np1 < ping-no-protocols.patch


--- ping.old    Tue May 30 22:26:48 2000
+++ ping.c      Tue May 30 22:26:54 2000
@@ -87,6 +87,7 @@
  */
 #ifdef __linux__
 #define SAFE_TO_DROP_ROOT
+#define NO_PROTOCOLS   // Elimnates the need for /etc/protocols and nss
libs
 #endif

 #if defined(__GLIBC__) && (__GLIBC__ >= 2)
@@ -223,13 +224,16 @@
        /*
         * Pull this stuff up front so we can drop root if desired.
         */
+#ifdef NO_PROTOCOLS
        setprotoent(0);  // Leave the /etc/protocols file open

        if (!(proto = getprotobyname("icmp"))) {
                (void)fprintf(stderr, "ping: unknown protocol icmp.\n");
                exit(2);
        }
-
+#else
+       proto->p_proto = 1; // ICMP, from /etc/protocols
+#endif
        if ((s = socket(AF_INET, SOCK_RAW, proto->p_proto)) < 0) {
                if (errno==EPERM) {
                        fprintf(stderr, "ping: ping must run as root\n");


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
