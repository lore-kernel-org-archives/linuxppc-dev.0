Subject: Re: Runtime Altivec detection
From: Albert Cahalan <albert@users.sourceforge.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: damm@opensource.se, hollis@austin.ibm.com,
	benh@kernel.crashing.org, ningerso@ruralcenter.org
Content-Type: text/plain
Date: 08 Mar 2003 23:01:47 -0500
Message-Id: <1047182509.1900.246.camel@cube>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


For those of you needing to get at ELF note info
to determine CPU features and other things, here
is the code procps-3.1.x has been using. You'll
need the appropriate ID code; here I use AT_CLKTCK
to determine USER_HZ. Pass the ID code into this
function, and you get back the ELF note value.

//////////////////////////////////////////////////////////////////////////
#ifndef AT_CLKTCK
#define AT_CLKTCK       17    // frequency of times()
#endif

#define ERROR_CODE 42  // choose something better!

extern char** environ;

// for ELF executables, notes are pushed before environment and args
static unsigned long find_elf_note(unsigned long findme){
  unsigned long *ep = (unsigned long *)environ;
  while(*ep++);
  while(*ep){
    if(ep[0]==findme) return ep[1];
    ep+=2;
  }
  return ERROR_CODE;
}

// Usage:
// Hertz = find_elf_note(AT_CLKTCK);

////////////////////////////////////////////////////////////////////////


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
