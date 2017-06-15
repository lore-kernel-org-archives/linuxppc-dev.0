Return-Path: <milian.wolff@kdab.com>
Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpHL90Dk2zDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 18:51:44 +1000 (AEST)
Sender: milian
From: Milian Wolff <milian.wolff@kdab.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Mark Wielaard <mark@klomp.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-kernel@vger.kernel.org, acme@kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] perf: libdw support for powerpc [ping]
Date: Thu, 15 Jun 2017 10:46:16 +0200
Message-ID: <3621613.kMnvz8Tm3d@milian-kdab2>
In-Reply-To: <59400ADD.4090709@linux.vnet.ibm.com>
References: <1496312681-20133-1-git-send-email-pbonzini@redhat.com>
 <1497354282.3755.201.camel@klomp.org> <59400ADD.4090709@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1743098.piPl8xHQTb";
 micalg="sha256"; protocol="application/pkcs7-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart1743098.piPl8xHQTb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, June 13, 2017 5:55:09 PM CEST Ravi Bangoria wrote:
> Hi Mark,
> 
> On Tuesday 13 June 2017 05:14 PM, Mark Wielaard wrote:
> > I see the same on very short runs. But when doing a slightly longer run,
> > even just using ls -lahR, which does some more work, then I do see user
> > backtraces. They are still missing for some of the early samples though.
> > It is as if there is a stack/memory address mismatch when the probe is
> > "too early" in ld.so.
> > 
> > Could you do a test run on some program that does some more work to see
> > if you never get any user stack traces, or if you only not get them for
> > some specific probes?
> 
> Thanks for checking. I tried a proper workload this time, but I still
> don't see any userspace callchain getting unwound.
> 
>   $ ./perf record --call-graph=dwarf -- zip -q -r temp.zip .
>   [ perf record: Woken up 2891 times to write data ]
>   [ perf record: Captured and wrote 723.290 MB perf.data (87934 samples) ]
> 
> 
> With libdw:
> 
>  $ LD_LIBRARY_PATH=/home/ravi/elfutils-git/usr/local/lib:\
>     /home/ravi/elfutils-git/usr/local/lib/elfutils/:$LD_LIBRARY_PATH\
>     ./perf script
> 
>   zip 16699  6857.354633:      37371 cycles:u:
>                    ecedc xmon_core
> (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux) 8c4fc
> __hash_page_64K (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
> 83450 hash_preload
> (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux) 7cc34
> update_mmu_cache (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
> 330064 alloc_set_pte
> (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux) 330efc do_fault
> (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux) 334580
> __handle_mm_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
> 335040 handle_mm_fault
> (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux) 7bf94
> do_page_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
> 7bec4 do_page_fault
> (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux) 7be78
> do_page_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
> 1a4f8 handle_page_fault
> (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
> 
>   zip 16699  6857.354663:     300677 cycles:u:
> 
>   zip 16699  6857.354895:     584131 cycles:u:
> 
>   zip 16699  6857.355312:     589687 cycles:u:
> 
>   zip 16699  6857.355606:     560142 cycles:u:

Just a quick question: Have you guys applied my recent patch:

commit 5ea0416f51cc93436bbe497c62ab49fd9cb245b6
Author: Milian Wolff <milian.wolff@kdab.com>
Date:   Thu Jun 1 23:00:21 2017 +0200

    perf report: Include partial stacks unwound with libdw
    
    So far the whole stack was thrown away when any error occurred before
    the maximum stack depth was unwound. This is actually a very common
    scenario though. The stacks that got unwound so far are still
    interesting. This removes a large chunk of differences when comparing
    perf script output for libunwind and libdw perf unwinding.

If not, then this could explain the issue you are seeing.

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart1743098.piPl8xHQTb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDEIw
ggXmMIIDzqADAgECAhBqm+E4O/8ra58B1dm4p1JWMA0GCSqGSIb3DQEBDAUAMIGFMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYD
VQQKExFDT01PRE8gQ0EgTGltaXRlZDErMCkGA1UEAxMiQ09NT0RPIFJTQSBDZXJ0aWZpY2F0aW9u
IEF1dGhvcml0eTAeFw0xMzAxMTAwMDAwMDBaFw0yODAxMDkyMzU5NTlaMIGXMQswCQYDVQQGEwJH
QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQK
ExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGlj
YXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AL6znlesKHZ1QBbHOAOY08YYdiFQ8yV5C0y1oNF9Olg+nKcxLqf2NHbZhGra0D00SOTq9bus3/mx
gUsg/Wh/eXQ0pnp8tZ8XZWAnlyKMpjL+qUByRjXCA6RQyDMqVaVUkbIr5SU0RDX/kSsKwer3H1pT
/HUrBN0X8sKtPTdGX8XAWt/VdMLBrZBlgvnkCos+KQWWCo63OTTqRvaq8aWccm+KOMjTcE6s2mj6
RkalweyDI7X+7U5lNo6jzC8RTXtVV4/Vwdax720YpMPJQaDaElmOupyTf1Qib+cpukNJnQmwygjD
8m046DQkLnpXNCAGjuJy1F5NATksUsbfJAr7FLUCAwEAAaOCATwwggE4MB8GA1UdIwQYMBaAFLuv
fgI9+qbxPISOre44mOzZMjLUMB0GA1UdDgQWBBSCr2yM+MX+lmF86B89K3FIXsSLwDAOBgNVHQ8B
Af8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADARBgNVHSAECjAIMAYGBFUdIAAwTAYDVR0fBEUw
QzBBoD+gPYY7aHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2VydGlmaWNhdGlvbkF1
dGhvcml0eS5jcmwwcQYIKwYBBQUHAQEEZTBjMDsGCCsGAQUFBzAChi9odHRwOi8vY3J0LmNvbW9k
b2NhLmNvbS9DT01PRE9SU0FBZGRUcnVzdENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Au
Y29tb2RvY2EuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQB4XLKBKDRPPO5fVs6fl1bsj6JrF/bz9kkI
BtTYLzXN30D+03Hj6OxCDBEaIeNmsBhrJmuubvyE7HtoSmR809AgcYboW+rcTNZ/8u/Hv+GTrNI/
AhqX2/kiQNxmgUPt/eJPs92Qclj0HnVyy9TnSvGkSDU7I5Px+TbO+88G4zipA2psZaWeEykgzClZ
lPz1FjTCkk77ZXp5cQYYexE6zeeN4/0OqqoAloFrjAF4o50YJafX8mnahjp3I2Y2mkjhk0xQfhNq
bzlLWPoT3m7j7U26u7zg6swjOq8hITYc3/np5tM5aVyu6t99p17bTbY7+1RTWBviN9YJzK8HxzOb
XYWBf/L+VGOYNsQDTxAk0Hbvb1j6KjUhg7fO294F29QIhhmiNOr84JHoy+fNLpfvYc/Q9EtFOI5I
SYgOxLk3nD/whbUe9rmEQXLp8MB933Ij474gwwCPUpwv9mj2PMnXoc7mbrS22XUSeTwxCTP9bcmU
dp4jmIoWfhQm7X9w/Zgddg+JZ/YnIHOwsGsaTUgj7fIvxqith7DoJC91WJ8Lce3CVJqb1XWeKIJ8
4F7YLXZN0oa7TktYgDdmQVxYkZo1c5noaDKH9Oq9cbm/vOYRUM1cWcef20Wkyk5S/GFyyPJwG0fR
1nRas3DqAf4cXxMiEKcff7PNa4M3RGTqH0pWR8p6EjCCBlQwggU8oAMCAQICEAf6KCF9+1doL2oE
OTPysLwwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1h
bmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0w
OwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWls
IENBMB4XDTE3MDUyMzAwMDAwMFoXDTIwMDUyMjIzNTk1OVowggFZMQswCQYDVQQGEwJTRTEPMA0G
A1UEERMGNjgzIDMxMRIwEAYDVQQIEwlWYWVybWxhbmQxEDAOBgNVBAcTB0hhZ2ZvcnMxGDAWBgNV
BAkTD05vcnJpbmdzIHZhZWcgMjEPMA0GA1UEEhMGQm94IDMwMSYwJAYDVQQKDB1LbGFyw6RsdmRh
bGVucyBEYXRha29uc3VsdCBBQjEdMBsGA1UECxMUQSBLREFCIEdyb3VwIENvbXBhbnkxQzBBBgNV
BAsMOklzc3VlZCB0aHJvdWdoIEtsYXLDpGx2ZGFsZW5zIERhdGFrb25zdWx0IEFCIEUtUEtJIE1h
bmFnZXIxHzAdBgNVBAsTFkNvcnBvcmF0ZSBTZWN1cmUgRW1haWwxFTATBgNVBAMTDE1pbGlhbiBX
b2xmZjEkMCIGCSqGSIb3DQEJARYVbWlsaWFuLndvbGZmQGtkYWIuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAxrzfNBVvRbiAknuTBXuQnNm9sLIFLo0vbPB6kswk78A3tA++Zn5c
lQUHhGlQq1cdYxagnUpqwvG3Sod15mPSOLkAPf/mabLN7p+lFbRaUP+97ZkTZtvb4BCC3osIEFI4
G393OSFWqc2qmIPE/SwSASbAA20Fcaa2M6P1lhOk/ttUh2jIurTPF0wUycIA7lBddrOgaOA8e2m6
iLTNHtlrfRbBaUX91D5ebY+UWmIjXSQ9+CtutMzBkwnF0rZKririvOkklg9VzEGNQVHrQfDF2s/U
pOtmtuVSwElauGT/KALyCFuIrYC1pmaKH8S1xODJqiRaf6jH8E+KQzKjyM/ErwIDAQABo4IB1TCC
AdEwHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFN+m99RtIuA1bSdw
6b1brOX7X3AJMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAgBgNVHREEGTAXgRVtaWxpYW4ud29s
ZmZAa2RhYi5jb20wDQYJKoZIhvcNAQELBQADggEBABf47LSJADqH+ow9INv3QM1NC/qq2bjxGvsZ
68iD11VEUAFlsYfsVTgQqUirwPVTYenXtwVBELHZyywsui1JxL7HKQetLQegDDP/RyfjReVaWxhy
3OpuItsgLVbru9QVgPifnoBFPtfZcwjeJDmeSbLT8oj4Rd0KYBOIve7WKvsfNPsNwfbLwY2zILkE
LjxZcVi2AwZHDyab+dzL/3YcLuJj1lSawBGn7ilpcdZydlv4aye51pD/MemLIYLcylt+ImrmjnTV
y+QlAHRF3s5FE8yAr+W1MBD/1bKZCSgFt8VQoAlz3hiQh8QqZp4Zl8WuVL4+mP/mT6VDEWgq/0Bo
cukxggJuMIICagIBATCBrDCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNV
BAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EC
EAf6KCF9+1doL2oEOTPysLwwDQYJYIZIAWUDBAIBBQCggZMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcwNjE1MDg0NjE2WjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQg7cbfGsH5I4zByCmOejhHbO0EXGtg
ApO6gmUgNerQJnowDQYJKoZIhvcNAQEBBQAEggEAj2nKfxjvLkD9HNPu8GAl9LvcNfuUFsWCdSG1
1aRbLnh89l3k/8f9Ex8W/0gv95YGrDZtLqBEWjHtKhkKO0Kf53MAUoGuf6IIsLTCeITA5PY5wzjp
2/sBvd3aBFFakX8G+9Ddyaja6DH2COXAjjY8oP4MgaY8lfQpot8UWvq9KYJwcBKUqIvagkUUoGFb
bzP0QdXN9FmvaKBzB47NYnlLmhrXwrQBoBwsPs0h36ospZumrbr+tSZnRUfkANSbvjdTpKfDmuDB
iLwSz2kvz7tRHP4nyYo2VVjJ8JhJERcWFdipNzNEKar8rnVTuzDp3SLb9Md8wYsu66ZdZyfBOBJi
8wAAAAAAAA==


--nextPart1743098.piPl8xHQTb--
