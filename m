Message-ID: <3A1AD5AD.F07B6804@sympatico.ca>
Date: Tue, 21 Nov 2000 15:06:05 -0500
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Reply-To: khendricks@ivey.uwo.ca
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Linker Experts Desperately Needed!
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I am trying to help the port of openoffice to ppc linux.  The build continues
for a long time then fails after testing a recently built shared library:

Checking DLL ../unxlngppc.pro/lib/libsba609lp.so ...: ERROR:
/usr/local/jdk/openoffice-609/solver/609/unxlngppc.pro/lib/libsvl609lp.so:
R_PPC_REL24 relocation out of range


The "Checking DLL" is actually a small c program which tries to dlopen the
library using RTLD_NOW.  The dlopen fails and the call to dlerror creates the
R_PPC_REL24 error message.

I manually checked the link paths, the LD_LIBRARY_PATH, etc and all are well.
No other library has failed in this way.  The code is all c++ code.  All of the
object files linked into this library were build with g++ -fPIC.

In an attempt to figure out what the problem symbol is, I tried modifying the
checkdll file to dlopen the library using RTLD_LAZY so that none of the function
relocations would happen and then I would use dlsym to look up each and every
unresolved symbol until I found the culprit.  Unfortunately dlopen with
RTLD_LAZY failed to open the library with the exact same error message, which
means that a non-function related symbol was the culprit.

I then used the LD_DEBUG=bindings trick when running my check program to get a
complete list of the bindings as they are made.  And I used readelf to dump a
list of all symbols of "OBJECT" type that were "UND" in the library to compare
against the bindings.

I then checked each and every symbol reported by readelf as being OBJECT and UND
against the log file showing the bindings.  This shortened my list to 144
possible culprits with no bindings made before the error terminated the binding
process, but each and ever one of those could be properly found in the libraries
linked into this one.

I am now stumped.

How do I find what is causing the R_PPC_REL24 error that prevents dlopen with
RTLD_LAZY from working?

If it matters I am using the following tools:

gcc-2.95.3-2f,
binutils 2.10.0.33
glibc-2.1.3-5a

Any help or ideas of how to attack this problem would be greatly appreciated.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
